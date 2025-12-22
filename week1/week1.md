# Week 1: System Planning and Architecture Design  
### Module: Operating Systems / Systems Administration  
### Student: Sohan Giri  
### Student ID: A00032373  
### Date: 2025-11-05  

---

## 1. Introduction

The purpose of Week 1 was to design and plan the system architecture used throughout this coursework. This phase focused on selecting an appropriate Linux server distribution, defining a secure and ethical network configuration, and justifying the workstation environment used for remote administration. Establishing a well-structured architecture at this stage is essential, as it forms the foundation for subsequent security hardening, performance testing, and system evaluation activities.

---

## 2. System Architecture Overview

### 2.1 Architecture Description

The system follows a dual-system client–server architecture consisting of a workstation and a server. The workstation is the host PC and serves as the administrative interface for managing the server. The server runs Ubuntu Server LTS in a headless configuration within VirtualBox, with no graphical user interface installed.

All administrative tasks are performed remotely using Secure Shell (SSH) from the workstation to the server. This design enforces command-line proficiency and mirrors industry-standard practices used in cloud and data-centre environments. Virtualisation provides isolation from external networks while still allowing secure communication between the workstation and server.

### 2.2 System Architecture Diagram

![System architecture diagram](../images/week1/system-architecture.png)

**Figure 1:** Dual-system architecture using a host PC as the workstation and Ubuntu Server LTS running headless in VirtualBox.

The diagram illustrates a clear separation of responsibilities between the workstation and the server. The workstation initiates SSH connections, executes monitoring scripts, and manages the GitHub Pages technical journal. The Ubuntu Server accepts SSH connections, runs Linux services, and enforces security controls. Communication between the systems occurs over an isolated VirtualBox virtual network.

---

## 3. Distribution Selection and Justification

### 3.1 Selected Server Distribution

**Chosen distribution: Ubuntu Server LTS**

Ubuntu Server LTS was selected as the server operating system due to its balance of stability, security, and long-term support. The Long-Term Support (LTS) release model provides five years of security updates and maintenance, making it suitable for production-style server environments.

Ubuntu Server includes native support for widely used security tools such as UFW (Uncomplicated Firewall), AppArmor, fail2ban, and automatic security updates. These tools align directly with the security requirements of the coursework and enable systematic implementation of industry-standard security controls. Additionally, Ubuntu benefits from extensive official documentation and a large community, supporting efficient troubleshooting and learning.

While Ubuntu Server LTS prioritises usability and rapid deployment, this comes at the cost of a slightly larger default attack surface compared to more minimal distributions such as Debian. This trade-off is acceptable for this coursework due to the strong emphasis on security hardening, monitoring, and real-world administrative tooling.

### 3.2 Comparison with Alternative Distributions

| Feature             | Ubuntu Server LTS | Debian            | Rocky Linux        |
|---------------------|------------------|-------------------|--------------------|
| Release model       | LTS (5 years)    | Very conservative | Enterprise-focused |
| Ease of use         | High             | Medium            | Medium             |
| Security framework  | AppArmor         | AppArmor          | SELinux            |
| Community support   | Very large       | Large             | Growing            |

---

## 4. Workstation Configuration Decision

### 4.1 Selected Workstation Option

**Selected option: Option B – Host PC**

The host PC was selected as the workstation for administering the Ubuntu Server. This approach avoids the overhead of running an additional desktop virtual machine and allows system resources to be concentrated on the server. The host PC already provides a reliable SSH client and access to development tools such as Git, making it well suited for remote administration and journal management.

This configuration also reflects professional practice, where system administrators and DevOps engineers commonly manage remote servers from their personal or corporate machines rather than from dedicated management systems.

---

## 5. Network Configuration

### 5.1 Virtual Network Setup

The workstation and server communicate through an isolated VirtualBox virtual network. This configuration enables secure SSH communication while ensuring that all security testing and scanning activities remain confined to the local environment.

Using an isolated network ensures ethical compliance with university policies by preventing interaction with external or university networks during security testing. It also reduces the system’s attack surface and provides a controlled environment for experimenting with firewall rules, intrusion detection mechanisms, and performance testing.

### 5.2 VirtualBox Network Adapter Configuration

The Ubuntu Server virtual machine was configured with two network adapters in VirtualBox to separate internet access from administrative traffic.

- **Adapter 1: NAT**
  - Purpose: Outbound internet connectivity
  - Used for system updates and package installation
  - Assigned IP address: `10.0.2.15/24` (via DHCP)

- **Adapter 2: Host-only Adapter**
  - Purpose: Secure administrative access from the workstation
  - Used exclusively for SSH, monitoring, and security testing
  - Assigned IP address: `192.168.56.101/24`

This dual-adapter configuration separates external network access from internal administrative traffic, reducing the server’s attack surface. It also ensures that all security testing activities, such as port scanning and intrusion detection, are confined to an isolated local environment in accordance with ethical and university guidelines.

---

## 6. Server System Specification (CLI Evidence)

### 6.0 Remote SSH Access Verification

![SSH connection verification](../images/week1/ssh-verification.png)

This screenshot demonstrates a successful SSH connection from the Windows host PC to the Ubuntu Server using a non-root user account. The presence of the `sohan@ubuntu-server` prompt confirms authenticated remote access and correct system context. All subsequent administrative commands were executed within this SSH session, enforcing command-line-only administration.

### 6.1 System Information Commands

**Command: `uname -a`**

![uname command output](../images/week1/uname.png)

The `uname -a` command displays kernel version, system architecture, and operating system details. This information confirms the underlying Linux kernel and platform used for the server, which is relevant for later analysis of performance and security behaviour.

**Command: `free -h`**

![free -h command output](../images/week1/free-h.png)

The `free -h` command displays system memory usage in a human-readable format. The output shows approximately 1.9 GiB of total RAM, with 340 MiB in use and 1.5 GiB available at idle. The system also reports 2.2 GiB of swap space, which is currently unused.

These values establish a baseline for comparing memory consumption under different workloads in later phases of the coursework.

**Command: `df -h`**

![df -h command output](../images/week1/df.png)

The `df -h` command displays disk usage across all mounted file systems. The root file system has a total capacity of 12 GB, with approximately 4.9 GB used and 5.9 GB available, resulting in 46% utilisation. This confirms sufficient disk capacity for application installation, log storage, and performance testing.

**Command: `ip addr`**

![ip addr command output](../images/week1/ipaddr.png)

The `ip addr` command displays all network interfaces and assigned IP addresses. The `enp0s3` interface is assigned `10.0.2.15/24` via the NAT adapter, providing outbound internet connectivity. The `enp0s8` interface is assigned `192.168.56.101/24` via the Host-only adapter and is used exclusively for secure SSH administration and testing.

**Command: `lsb_release -a`**

![lsb_release output](../images/week1/lsb.png)

The `lsb_release -a` command confirms that the system is running Ubuntu 24.04.3 LTS. Using an LTS release ensures long-term stability and consistent security updates, which is critical for server environments.

---

## 7. Administrative Constraints

The following administrative constraints were applied from the beginning of the coursework:

- The server operates in a headless configuration with no graphical interface.
- All server administration is performed exclusively via SSH.
- No graphical management tools are used on the server.
- Routine use of the VirtualBox console is avoided.

These constraints align the system with professional server administration standards and reinforce command-line proficiency.

---

## 8. Reflection

This week highlighted the importance of careful system planning and architectural decision-making. Selecting an appropriate server distribution and workstation environment required balancing usability, security, and performance considerations. Designing the architecture in advance provided a clear roadmap for subsequent weeks, particularly for security hardening and performance evaluation tasks.

This phase reinforced how operating system choices directly influence security capabilities, administrative overhead, and performance testing flexibility. Early architectural decisions constrained later configuration options, demonstrating the interconnected nature of operating system design, security policy, and system performance.

---

## 9. References

[1] Ubuntu, *Ubuntu Server Documentation*. [Online]. Available: https://ubuntu.com/server/docs. Accessed: 05-Nov-2025.  

[2] Wikipedia, *Deployment Diagram*. [Online]. Available: https://en.wikipedia.org/wiki/Deployment_diagram. Accessed: 05-Nov-2025.  

[3] GeeksforGeeks, *How to Draw Architecture Diagrams*. [Online]. Available: https://www.geeksforgeeks.org/how-to-draw-architecture-diagrams/. Accessed: 05-Nov-2025.
