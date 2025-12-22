# Week 7: Security Audit and System Evaluation  
### Module: Operating Systems / Systems Administration  
### Student: Sohan Giri  
### Student ID: A00032373  
### Date: 2025-12-17  

---

## 1. Introduction

The purpose of Week 7 was to conduct a comprehensive security audit and overall system evaluation of the Ubuntu Server. This phase aimed to assess the effectiveness of the security controls implemented in previous weeks and to identify any remaining vulnerabilities or risks. Industry-standard auditing tools were used to evaluate system hardening, network exposure, access control, and service configuration.

The findings from this audit provide a final assessment of the system’s security posture and highlight key trade-offs between security, performance, and administrative usability.

---

## 2. Security Audit Methodology

The security audit was conducted using a layered approach combining automated tools, manual verification, and configuration review. All audit activities were performed remotely via SSH from the workstation and confined to the isolated VirtualBox Host-only network to ensure ethical compliance.

The audit focused on the following areas:

- System hardening and configuration compliance  
- Network exposure and open services  
- Authentication and access control  
- Intrusion detection effectiveness  
- Residual risks and limitations  

---

## 3. System Hardening Audit with Lynis

### 3.1 Lynis Scan Execution

![Lynis security audit](../images/week7/lynis-scan.png)

**Figure 7.1:** Execution of the Lynis security audit tool on the Ubuntu Server.

Lynis was used to perform a comprehensive system security audit, analysing configuration files, permissions, services, kernel parameters, and installed software. The scan was executed after all security controls had been implemented to evaluate the final security posture.

---

### 3.2 Lynis Results and Improvements

The Lynis audit produced a strong overall hardening score, indicating that the majority of recommended security controls were correctly implemented. Improvements over the default installation were observed in the following areas:

- SSH hardening (key-based authentication, root login disabled)  
- Firewall configuration with restricted inbound access  
- Automatic security updates enabled  
- Intrusion prevention via fail2ban  
- Mandatory access control using AppArmor  

Several low-risk warnings remained, primarily relating to optional kernel hardening and additional logging recommendations. These were assessed as acceptable trade-offs given the coursework scope and system purpose.

---

## 4. Network Security Assessment with nmap

### 4.1 Network Scan Methodology

![nmap scan results](../images/week7/nmap-scan.png)

**Figure 7.2:** nmap scan of the Ubuntu Server from the workstation within the Host-only network.

A network security assessment was performed using `nmap` from the workstation to identify exposed services and verify firewall effectiveness. Scanning was limited to the Host-only network in accordance with ethical guidelines.

---

### 4.2 nmap Results and Analysis

The nmap scan confirmed that only **port 22 (SSH)** was open and accessible from the trusted workstation IP address. No additional services or unintended ports were exposed.

This result verifies that the UFW firewall rules are correctly enforced and that the server’s network attack surface has been minimised. The absence of unnecessary open ports significantly reduces the risk of remote exploitation.

---

## 5. Authentication and Access Control Verification

### 5.1 SSH Security Verification

Manual verification confirmed that:

- Password-based SSH authentication is disabled  
- Root login via SSH is prohibited  
- Key-based authentication is enforced  
- SSH access is restricted to a single trusted IP  

These controls collectively protect against brute-force attacks, credential theft, and unauthorised remote access.

---

### 5.2 Mandatory Access Control Evaluation

AppArmor profiles were verified to be active and operating in enforce mode for multiple system services. This ensures that even if a service is compromised, its ability to access system resources is strictly limited.

Mandatory access control provides an additional containment layer beyond traditional discretionary permissions, strengthening the system’s defence-in-depth strategy.

---

## 6. Service Audit and Justification

A review of all running services was conducted to ensure that only essential services are enabled.

The following core services were identified and justified:

- **OpenSSH Server** – Required for secure remote administration  
- **systemd services** – Required for core operating system functionality  
- **fail2ban** – Provides intrusion prevention and log monitoring  

No unnecessary or unused services were found to be running. Disabling non-essential services reduces system complexity and further minimises the attack surface.

---

## 7. Residual Risk Assessment

Despite strong security controls, some residual risks remain:

- Kernel-level exploits that bypass user-space controls  
- Zero-day vulnerabilities not yet addressed by updates  
- Physical access to the host system (outside VM scope)  

These risks are mitigated as far as reasonably possible through timely updates, network isolation, and layered security controls. Completely eliminating all risk is not feasible, but the current configuration significantly reduces the likelihood and impact of compromise.

---

## 8. Overall System Evaluation

The final system demonstrates a well-balanced security configuration suitable for a headless Linux server environment. Security hardening measures were applied systematically, verified through automated tools, and supported by manual inspection.

Key trade-offs were observed between:

- **Security and usability** – Strict SSH controls increase security but require key management  
- **Security and performance** – Monitoring and intrusion detection introduce minor overhead  
- **Automation and control** – Automatic updates reduce risk but require trust in update sources  

These trade-offs were carefully managed to maintain system stability while maximising security.

---

## 9. Reflection

Week 7 reinforced the importance of auditing and verification in system administration. Implementing security controls alone is insufficient without validation through testing and review. Using tools such as Lynis and nmap provided objective evidence of system hardening, while manual inspection ensured configuration intent matched actual behaviour.

This phase highlighted how operating systems function as integrated systems where security, performance, and usability must be continuously balanced.

---

## 10. Conclusion

Week 7 successfully demonstrated a comprehensive security audit and final system evaluation of the Ubuntu Server. The results confirm that the system is securely configured, resilient against common attack vectors, and aligned with professional best practices.

The audit concludes the coursework by validating earlier implementation decisions and providing evidence-based insight into the effectiveness of operating system security mechanisms.

---

## 11. References

[1] CIS, *Lynis – Security Auditing Tool*. [Online]. Available: https://cisofy.com/lynis/. Accessed: 17-Dec-2025.  

[2] nmap, *Network Mapper Documentation*. [Online]. Available: https://nmap.org/docs.html. Accessed: 17-Dec-2025.  

[3] Ubuntu, *Ubuntu Server Security*. [Online]. Available: https://ubuntu.com/security. Accessed: 17-Dec-2025.
