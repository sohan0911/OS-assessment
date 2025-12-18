Week 2 – Security Planning and Testing Methodology

1. Introduction
The purpose of Week 2 was to design a comprehensive security baseline and define a performance testing methodology for the Ubuntu Server. This phase focused on identifying potential security threats, planning mitigation strategies, and establishing monitoring approaches that would be used throughout the coursework. Security planning at this stage ensures that system hardening is systematic, measurable, and aligned with professional best practices.

2. Performance Testing Methodology
2.1 Monitoring Approach
Performance monitoring will be conducted remotely from the Windows host PC using SSH-based commands and scripts. This ensures that monitoring activities do not interfere with the server’s workload and maintains compliance with the coursework’s remote administration constraint.
Metrics to be collected include:
•	CPU usage
•	Memory utilisation
•	Disk I/O activity
•	Network throughput and latency
•	System load averages
Monitoring data will be collected both at baseline and during application load testing, enabling comparative analysis of system behaviour under different workloads.

2.2 Testing Strategy
Performance testing will be conducted in four stages:
1.	Baseline Testing: Measurements taken when the system is idle.
2.	Application Load Testing: Measurements collected while selected applications are running.
3.	Bottleneck Identification: Analysis of resource saturation and performance constraints.
4.	Optimisation Testing: Re-testing after implementing configuration or tuning improvements.
This structured approach enables quantitative evaluation of operating system behaviour and supports later optimisation analysis.

3. Security Configuration Checklist
The following checklist defines the planned security controls to be implemented and verified in later weeks:
Security Area	Planned Control	Purpose
SSH Security	Key-based authentication, disable root login	Prevent brute-force and unauthorised access
Firewall	UFW allowing SSH only from host IP	Restrict network access
Access Control	AppArmor enforcement	Limit application privileges
Updates	Automatic security updates	Reduce vulnerability exposure
User Management	Non-root admin user with sudo	Principle of least privilege
Intrusion Detection	fail2ban	Detect and block repeated login attempts
This checklist provides a structured security baseline against which implementation and verification will be measured.

4. Threat Model
4.1 Threat Model Overview
The threat model focuses on realistic attack vectors relevant to a headless Linux server administered remotely via SSH. Potential threats were identified based on common misconfigurations, exposed services, and known attack techniques targeting Linux server environments. Each identified threat is mapped to one or more mitigation strategies that will be implemented and verified in later phases of the coursework.
![Threat model diagram](../images/week2/threatmodel.png)

**Figure 7:** Dual-system architecture showing the Windows host PC as the workstation and Ubuntu Server LTS running headless in VirtualBox.

Figure 1: Threat model for the Ubuntu Server VM.
The diagram illustrates key threats including brute-force SSH attacks, network scanning, firewall misconfiguration, privilege escalation, and exploitation of outdated packages. Each threat is mapped to planned mitigation controls such as UFW firewall rules, SSH hardening, fail2ban, AppArmor, least-privilege user management, and automatic security updates.

4.2 Identified Threats and Mitigation Strategies
Threat	Description	Potential Impact	Planned Mitigation
Brute-force SSH attacks	Automated attempts to guess SSH credentials	Unauthorised access to the server	SSH key-based authentication, disable password login, fail2ban
Network scanning and service enumeration	Port scanning to identify exposed services	Increased attack surface and reconnaissance	UFW firewall restricting access to SSH from host IP only
Firewall misconfiguration	Overly permissive or incorrect firewall rules	Unintended external access	Explicit UFW rules, rule verification and documentation
Privilege escalation	Abuse of elevated privileges or misconfigured sudo access	Full system compromise	Non-root administrative user, controlled sudo privileges
Outdated packages and unpatched vulnerabilities	Exploitation of known vulnerabilities in outdated software	Remote code execution or data compromise	Automatic security updates, regular package updates

4.3 Threat Mitigation Rationale
The selected mitigation strategies follow industry-standard security best practices for Linux server environments. Key-based SSH authentication and firewall restrictions reduce exposure to external threats, while fail2ban provides active intrusion detection against repeated unauthorised access attempts. Mandatory access control using AppArmor limits the impact of potential service compromise, and automatic security updates reduce the risk associated with known vulnerabilities. Together, these controls establish a layered defence-in-depth security model.

5. Network Security Considerations
All security testing and monitoring activities will be conducted within the isolated VirtualBox Host-only network. Tools such as nmap will only be used against the Ubuntu Server VM and never against external or university networks. This ensures ethical compliance and prevents unintended impact on other systems.

6. Reflection
This week emphasised the importance of proactive security planning and structured testing methodologies. Identifying threats in advance highlighted how misconfiguration can lead to significant vulnerabilities. Establishing a security checklist and testing plan provides a clear framework for implementing and evaluating security controls in later weeks.

7. References 
[1] Ubuntu, Security – Ubuntu Server Guide. [Online]. Available: https://ubuntu.com/server/docs/security.
[2] OWASP, Threat Modeling. [Online]. Available: https://owasp.org/www-community/Threat_Modeling.

