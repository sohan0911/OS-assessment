# Week 2: Security Planning and Testing Methodology  
### Module: Operating Systems / Systems Administration  
### Student: Sohan Giri  
### Student ID: A00032373  
### Date: 2025-11-12  

---

## 1. Introduction

The purpose of Week 2 was to design a comprehensive security baseline and define a performance testing methodology for the Ubuntu Server. This phase focused on identifying realistic security threats, planning appropriate mitigation strategies, and establishing monitoring approaches that would be applied consistently throughout the coursework. Early security planning ensures that system hardening is systematic, measurable, and aligned with professional best practices for Linux server administration.

Throughout this journal, the term *workstation* refers to the Windows host PC used for remote administration of the Ubuntu Server.

---

## 2. Performance Testing Methodology

### 2.1 Monitoring Approach

Performance monitoring will be conducted remotely from the workstation using SSH-based commands and scripts. This approach ensures that monitoring activities do not interfere with the server’s workload and maintains compliance with the coursework requirement for remote administration.

The following metrics will be collected:

- CPU usage  
- Memory utilisation  
- Disk I/O activity  
- Network throughput and latency  
- System load averages  

Monitoring data will be collected during both baseline conditions and application load testing. This allows for direct comparison of system behaviour under different workloads and supports quantitative performance analysis in later phases.

### 2.2 Testing Strategy

Performance testing will be conducted using a structured four-stage methodology:

1. **Baseline Testing** – Measurements collected when the system is idle  
2. **Application Load Testing** – Measurements collected while selected applications are running  
3. **Bottleneck Identification** – Analysis of resource saturation and performance constraints  
4. **Optimisation Testing** – Re-testing after configuration changes or tuning improvements  

While extensive monitoring provides detailed insight into system behaviour, it can introduce minor overhead. For this reason, monitoring is performed remotely from the workstation to minimise performance impact on the server itself.

This structured approach enables systematic evaluation of operating system behaviour and supports informed optimisation decisions based on measurable data.

---

## 3. Security Configuration Checklist

The following checklist defines the planned security controls to be implemented and verified in later weeks. This checklist establishes a security baseline against which implementation, verification, and auditing will be measured.

| Security Area        | Planned Control                                   | Purpose                                   |
|----------------------|---------------------------------------------------|-------------------------------------------|
| SSH Security         | Key-based authentication, disable root login      | Prevent brute-force and unauthorised access |
| Firewall             | UFW allowing SSH only from host IP                | Restrict network access                   |
| Access Control       | AppArmor enforcement                              | Limit application privileges              |
| Updates              | Automatic security updates                        | Reduce vulnerability exposure             |
| User Management      | Non-root admin user with sudo                     | Enforce least-privilege principle          |
| Intrusion Detection  | fail2ban                                          | Detect and block repeated login attempts   |

---

## 4. Threat Model

### 4.1 Threat Model Overview

The threat model focuses on realistic attack vectors relevant to a headless Linux server administered remotely via SSH. Potential threats were identified based on common server misconfigurations, exposed services, and known attack techniques targeting Linux environments. Each identified threat is mapped to one or more mitigation strategies that will be implemented and verified in later phases of the coursework.

![Threat model diagram](../images/week2/threatmodel.png)

**Figure 2:** Threat model for the Ubuntu Server virtual machine within the isolated VirtualBox network.

The diagram illustrates key threats including brute-force SSH attacks, network scanning, firewall misconfiguration, privilege escalation, and exploitation of outdated software. These threats are mapped to mitigation controls such as SSH hardening, UFW firewall rules, fail2ban, AppArmor, least-privilege user management, and automatic security updates.

### 4.2 Identified Threats and Mitigation Strategies

| Threat                               | Description                                              | Potential Impact                          | Planned Mitigation                                                  |
|--------------------------------------|----------------------------------------------------------|-------------------------------------------|----------------------------------------------------------------------|
| Brute-force SSH attacks              | Automated attempts to guess SSH credentials               | Unauthorised access to the server         | SSH key-based authentication, disable passwords, fail2ban           |
| Network scanning and service enumeration | Port scanning to identify exposed services                | Increased attack surface and reconnaissance | UFW firewall restricting SSH access to host IP only                 |
| Firewall misconfiguration            | Overly permissive or incorrect firewall rules             | Unintended external access                | Explicit UFW rules, verification, and documentation                  |
| Privilege escalation                 | Abuse of elevated privileges or misconfigured sudo        | Full system compromise                   | Non-root administrative user, controlled sudo permissions            |
| Outdated packages and vulnerabilities| Exploitation of known software vulnerabilities            | Remote code execution or data compromise | Automatic security updates and regular package maintenance           |

### 4.3 Threat Mitigation Rationale

The selected mitigation strategies follow industry-standard best practices for Linux server security. Key-based SSH authentication and firewall restrictions significantly reduce exposure to unauthorised access, while fail2ban provides active intrusion detection against repeated login attempts. Mandatory access control using AppArmor limits the impact of potential service compromise, and automatic security updates reduce the risk associated with known vulnerabilities. Together, these controls establish a layered defence-in-depth security model.

These mitigation strategies will be validated through configuration evidence, security auditing tools, and live command-line demonstrations in later phases of the coursework.

---

## 5. Network Security Considerations

All security testing and monitoring activities will be conducted exclusively within the isolated VirtualBox Host-only network. Tools such as `nmap` will only be used against the Ubuntu Server virtual machine and never against external or university networks. This ensures ethical compliance with university policies and prevents unintended impact on other systems.

---

## 6. Reflection

This week emphasised the importance of proactive security planning and structured testing methodologies. Identifying threats in advance highlighted how misconfiguration can introduce significant vulnerabilities in server environments. Establishing a security checklist and performance testing framework provides a clear foundation for implementing, verifying, and auditing security controls in later weeks of the coursework.

---

## 7. References

[1] Ubuntu, *Security – Ubuntu Server Guide*. [Online]. Available: https://ubuntu.com/server/docs/security. Accessed: 12-Nov-2025.  

[2] OWASP, *Threat Modeling*. [Online]. Available: https://owasp.org/www-community/Threat_Modeling. Accessed: 12-Nov-2025.
