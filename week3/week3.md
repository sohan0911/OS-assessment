Week 3 – Application Selection for Performance Testing

1. Introduction
The purpose of Week 3 was to select a range of applications representing different workload types in order to evaluate operating system performance under varying conditions. The selected applications were chosen to stress different system resources, including CPU, memory, disk I/O, and network performance. This structured selection enables systematic performance analysis and supports later optimisation and trade-off evaluation.

2. Application Selection Strategy
Applications were selected based on the following criteria:
•	Each application targets a different system resource
•	Applications are lightweight and suitable for a virtualised environment
•	Tools are commonly used in Linux server performance analysis
•	Results are measurable and reproducible
This approach ensures that performance testing remains controlled, ethical, and relevant to real-world server workloads.

3. Application Selection Matrix
Application	Workload Type	Resource Stressed	Justification
stress-ng	CPU-intensive	CPU	Generates controlled CPU load to analyse scheduler behaviour and CPU utilisation
stress-ng	Memory-intensive	RAM	Allocates memory to test memory pressure and swap behaviour
fio	I/O-intensive	Disk I/O	Measures disk read/write performance and latency
iperf3	Network-intensive	Network	Measures network throughput and latency between host and server
openssh-server	Server workload	CPU, Network	Represents a real server service handling authenticated remote connections

4. Installation Documentation (via SSH)
4.1 Updating Package Lists
![Updating packages list](../images/week3/update.png)
The sudo apt update command refreshes the local package index by retrieving the latest package information from configured Ubuntu repositories. This ensures that any software installed uses the most recent available versions and dependencies, reducing the risk of compatibility or security issues.

4.2 Installing Performance Testing Tools

![Installing performance tool](../images/week3/install.png)

**Figure 7:** Dual-system architecture showing the Windows host PC as the workstation and Ubuntu Server LTS running headless in VirtualBox.
This command installs the selected benchmarking tools required for performance testing.
•	stress-ng is used to generate CPU and memory workloads.
•	fio is used to benchmark disk I/O performance.
•	iperf3 is used to measure network throughput and latency.
The -y flag automatically confirms the installation, enabling non-interactive execution while maintaining control through sudo. Installing these tools at this stage prepares the system for later testing without executing any workloads prematurely.

5. Expected Resource Profiles
Application	Expected CPU Impact	Expected Memory Impact	Expected Disk/Network Impact
stress-ng (CPU)	High	Low	Minimal
stress-ng (Memory)	Moderate	High	Minimal
fio	Low	Low	High disk I/O
iperf3	Low	Low	High network throughput
SSH service	Low	Low	Moderate network activity
6. Monitoring Strategy
Performance metrics will be collected remotely from the Windows host PC using SSH-based commands and scripts.
6.1 Monitoring Tools
Planned monitoring commands include:
•	top / htop – real-time CPU and memory usage
•	vmstat – memory and process statistics
•	iostat – disk I/O performance
•	ss – network socket statistics
•	ping – latency measurement
6.2 Data Collection Approach
•	Metrics will be collected at baseline (idle) and under load
•	Sampling will occur at regular intervals
•	Results will be recorded and later visualised using tables and graphs
This structured approach enables quantitative comparison and supports optimisation analysis.

7. Reflection
This week demonstrated the importance of selecting appropriate workloads to evaluate operating system performance effectively. By choosing applications that isolate specific system resources, it becomes easier to identify bottlenecks and analyse trade-offs between performance, resource utilisation, and security controls. This preparation provides a clear foundation for performance testing and optimisation in later weeks.

8. References
[1] Linux Man Pages, stress-ng. [Online]. Available: https://manpages.ubuntu.com/manpages/stress-ng.html
[2] Linux Man Pages, fio. [Online]. Available: https://manpages.ubuntu.com/manpages/fio.html
[3] ESnet, iperf3 Documentation. [Online]. Available: https://iperf.fr/iperf-doc.php
