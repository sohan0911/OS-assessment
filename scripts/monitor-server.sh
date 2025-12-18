#!/bin/bash
# ============================================================
# monitor-server.sh
# Purpose: Collect performance metrics from Ubuntu Server via SSH
# Run from: Workstation (Windows host using Git Bash or WSL)
# Target: Ubuntu Server (headless) on Host-only network
# ============================================================

SERVER_USER="sohan"
SERVER_IP="192.168.56.101"
SERVER="${SERVER_USER}@${SERVER_IP}"

# Timestamp for logging (optional)
TS="$(date +%Y-%m-%d_%H-%M-%S)"

echo "============================================================"
echo " Remote Monitoring Script"
echo " Target:   ${SERVER}"
echo " Date:     $(date)"
echo "============================================================"
echo

# Helper: run a remote command with a heading
run_remote() {
  local title="$1"
  local cmd="$2"
  echo "--------------------"
  echo "$title"
  echo "--------------------"
  ssh "$SERVER" "$cmd"
  echo
}

# 1) Uptime + load
run_remote "1) Uptime and Load" "uptime"

# 2) CPU summary (lightweight)
run_remote "2) CPU Summary" "lscpu | grep -E 'Model name|CPU\\(s\\)|Thread\\(s\\) per core|Core\\(s\\) per socket'"

# 3) Memory usage
run_remote "3) Memory Usage (free -h)" "free -h"

# 4) Disk usage (root filesystem)
run_remote "4) Disk Usage (df -h /)" "df -h /"

# 5) Disk I/O snapshot (quick)
run_remote "5) Disk I/O Snapshot (vmstat 1 3)" "vmstat 1 3"

# 6) Network interfaces + IPs
run_remote "6) Network Interfaces (ip -br addr)" "ip -br addr"

# 7) Top CPU processes
run_remote "7) Top CPU Processes" "ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6"

# 8) Top memory processes
run_remote "8) Top Memory Processes" "ps -eo pid,comm,%mem,%cpu --sort=-%mem | head -n 6"

echo "============================================================"
echo " Monitoring complete."
echo "============================================================"
