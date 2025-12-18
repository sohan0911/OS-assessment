#!/bin/bash
# ============================================================
# security-baseline.sh
# Purpose: Verify key security controls implemented in Weeks 4–5
# Author: Sohan
# Run: ./security-baseline.sh
# Notes:
#  - Some checks require sudo access.
#  - Output is designed to be clear for screenshots/video demo.
# ============================================================

set -u  # Treat unset variables as an error

# ---------- Helper functions ----------
ok()    { echo "[OK]    $1"; }
warn()  { echo "[WARN]  $1"; }
fail()  { echo "[FAIL]  $1"; }

header() {
  echo ""
  echo "============================================================"
  echo "$1"
  echo "============================================================"
}

# ---------- Basic context ----------
header "System Context"
echo "Hostname: $(hostname)"
echo "User:     $(whoami)"
echo "Date:     $(date)"
echo "Uptime:   $(uptime -p 2>/dev/null || uptime)"

# ---------- 1) SSH hardening checks ----------
header "1) SSH Hardening (sshd_config)"

SSHD_CONFIG="/etc/ssh/sshd_config"

# Check that the config file exists
if [[ -f "$SSHD_CONFIG" ]]; then
  ok "Found $SSHD_CONFIG"
else
  fail "Missing $SSHD_CONFIG"
fi

# Function to check exact setting in sshd_config (ignores commented lines)
check_sshd_setting() {
  local key="$1"
  local expected="$2"
  if sudo grep -Eq "^[[:space:]]*${key}[[:space:]]+${expected}[[:space:]]*$" "$SSHD_CONFIG"; then
    ok "SSH setting: ${key} ${expected}"
  else
    fail "SSH setting not enforced: expected '${key} ${expected}' in $SSHD_CONFIG"
  fi
}

check_sshd_setting "PasswordAuthentication" "no"
check_sshd_setting "PermitRootLogin" "no"
check_sshd_setting "PubkeyAuthentication" "yes"

# Verify SSH service is running
if systemctl is-active --quiet ssh; then
  ok "SSH service is active"
else
  fail "SSH service is NOT active"
fi

# ---------- 2) Firewall checks ----------
header "2) Firewall (UFW)"

if command -v ufw >/dev/null 2>&1; then
  ok "UFW is installed"
else
  fail "UFW is not installed"
fi

UFW_STATUS="$(sudo ufw status verbose 2>/dev/null || true)"

if echo "$UFW_STATUS" | grep -q "Status: active"; then
  ok "UFW is active"
else
  fail "UFW is NOT active"
fi

# Default policy check (incoming deny is expected)
if echo "$UFW_STATUS" | grep -q "Default: deny (incoming)"; then
  ok "UFW default incoming policy is deny"
else
  warn "UFW default incoming policy is not 'deny (incoming)' (review recommended)"
fi

# Check SSH rule restricted to host-only IP (update this to YOUR host IP)
HOST_IP="192.168.56.1"

if echo "$UFW_STATUS" | grep -Eq "22\s+ALLOW IN\s+${HOST_IP}"; then
  ok "SSH is restricted to workstation IP (${HOST_IP})"
else
  warn "Could not confirm SSH restricted to ${HOST_IP}. Check: 'sudo ufw status verbose'"
fi

# ---------- 3) AppArmor checks ----------
header "3) Mandatory Access Control (AppArmor)"

if command -v aa-status >/dev/null 2>&1; then
  ok "aa-status available"
else
  fail "aa-status not found (AppArmor tools missing?)"
fi

AA_OUT="$(sudo aa-status 2>/dev/null || true)"

if echo "$AA_OUT" | grep -q "apparmor module is loaded"; then
  ok "AppArmor module is loaded"
else
  fail "AppArmor module not loaded"
fi

# Count enforced profiles (your system showed 24)
ENFORCED_COUNT="$(sudo aa-status --enforced 2>/dev/null | tail -n 1 | tr -d ' ' || true)"

if [[ "$ENFORCED_COUNT" =~ ^[0-9]+$ ]]; then
  ok "Enforced AppArmor profiles: $ENFORCED_COUNT"
else
  warn "Could not read enforced profile count"
fi

# ---------- 4) Automatic security updates ----------
header "4) Automatic Security Updates (unattended-upgrades)"

if dpkg -l | grep -q "^ii  unattended-upgrades"; then
  ok "unattended-upgrades is installed"
else
  fail "unattended-upgrades is NOT installed"
fi

# Check apt periodic config (common on Ubuntu)
AUTO_CFG="/etc/apt/apt.conf.d/20auto-upgrades"
if [[ -f "$AUTO_CFG" ]]; then
  ok "Found $AUTO_CFG"
  if grep -Eq 'APT::Periodic::Unattended-Upgrade\s+"1";' "$AUTO_CFG"; then
    ok "Unattended upgrades enabled in 20auto-upgrades"
  else
    warn "Unattended upgrades setting not found in 20auto-upgrades (check dpkg-reconfigure)"
  fi
else
  warn "Missing $AUTO_CFG (system may still be configured elsewhere)"
fi

# Service status (may show active (waiting) which is fine)
if systemctl is-enabled --quiet unattended-upgrades 2>/dev/null; then
  ok "unattended-upgrades service enabled"
else
  warn "unattended-upgrades service not enabled (verify configuration)"
fi

# ---------- 5) fail2ban checks ----------
header "5) Intrusion Prevention (fail2ban)"

if systemctl is-active --quiet fail2ban; then
  ok "fail2ban service is active"
else
  fail "fail2ban service is NOT active"
fi

# Check fail2ban client and sshd jail status
if command -v fail2ban-client >/dev/null 2>&1; then
  ok "fail2ban-client available"
  # Overall status
  sudo fail2ban-client status >/dev/null 2>&1 && ok "fail2ban-client status works" || warn "fail2ban-client status failed"
  # SSH jail (may be named sshd on Ubuntu)
  if sudo fail2ban-client status sshd >/dev/null 2>&1; then
    ok "fail2ban sshd jail is available"
  else
    warn "fail2ban sshd jail not found (check jail configuration)"
  fi
else
  fail "fail2ban-client not found"
fi

# ---------- 6) Basic listening service check ----------
header "6) Listening Services Check (SSH expected)"

# Confirm SSH is listening on port 22
if ss -tuln | grep -q ":22"; then
  ok "Port 22 is listening (SSH)"
else
  warn "Port 22 does not appear to be listening (verify SSH service)"
fi

header "Security Baseline Summary"
echo "Review any [WARN] or [FAIL] items above and remediate as needed."
echo "Done."
