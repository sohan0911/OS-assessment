# Operating Systems Coursework – Linux Server Configuration & Security Audit

## Module Information
- **Module:** Operating Systems  
- **Module Code:** CMPN202  
- **Programme:** BSc Computer Science  
- **Student Name:** Sohan Giri  
- **Student ID:** A00032373  
- **Academic Year:** 2024–2025  

---

## Project Overview

This repository documents the configuration, security hardening, performance evaluation, and auditing of a headless Ubuntu Server system. The coursework follows a professional dual-system architecture, where a Linux server is administered remotely via SSH from a separate workstation, reflecting real-world system administration and DevOps practices.

The project is structured as a **7-week technical journal**, published using **GitHub Pages**, and supported by a recorded video demonstration.

---

## System Architecture

The system uses a **dual-system model**:

- **Workstation:** Windows 11 host machine  
- **Server:** Ubuntu Server LTS (headless) running in VirtualBox  

All server administration is performed **exclusively via SSH** from the workstation. The server has no graphical interface installed.

### Key Architectural Principles
- Command-line–only server management  
- Network isolation using VirtualBox Host-only networking  
- Secure remote administration  
- Ethical, local-only security testing  

---

## Network Configuration

- **Adapter 1 (NAT):**  
  Used for outbound internet access (updates and package installation)

- **Adapter 2 (Host-only):**  
  Used for secure SSH access, monitoring, and security testing

All firewall rules restrict inbound access to the trusted workstation IP.

---

## Security Controls Implemented

The following industry-standard security controls were implemented and verified:

- SSH key-based authentication  
- Password authentication disabled  
- Root login disabled  
- UFW firewall with default deny policy  
- SSH access restricted to a single trusted IP  
- Non-root administrative user with sudo  
- Mandatory access control using AppArmor  
- Automatic security updates (unattended-upgrades)  
- Intrusion prevention using fail2ban  

---

## Performance & Monitoring

System performance was evaluated using representative workloads targeting:

- CPU utilisation  
- Memory pressure  
- Disk I/O performance  
- Network throughput  

Monitoring and verification were performed remotely using SSH-based commands and scripts to minimise server overhead and maintain professional administration practices.

---

## Security Auditing

Final system security was audited using:

- **Lynis** – system hardening audit  
- **nmap** – network exposure verification  

Audit results were analysed critically, and optional recommendations were assessed based on environmental risk, performance trade-offs, and operational relevance.

---

## Repository Structure

```text
/
├── README.md
├── index.md
├── week1.md
├── week2.md
├── week3.md
├── week4.md
├── week5.md
├── week6.md
├── week7.md
├── images/
│   ├── week1/
│   ├── week2/
│   ├── week3/
│   ├── week4/
│   ├── week5/
│   ├── week6/
│   └── week7/
└── scripts/
    ├── security-baseline.sh
    └── monitor-server.sh
