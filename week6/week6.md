# Week 6: Performance Evaluation and Analysis  
### Module: Operating Systems / Systems Administration  
### Student: Sohan Giri  
### Student ID: A00032373  
### Date: 2025-12-10  

---

## 1. Introduction

Week 6 focused on evaluating the performance of the Ubuntu Server under different workload conditions. Baseline measurements were first collected to establish normal system behaviour under idle conditions. The system was then subjected to controlled CPU, memory, disk I/O, and network stress tests using industry-standard benchmarking tools.

The collected results were analysed to identify performance bottlenecks, assess system stability, and evaluate operating system behaviour under sustained load.

---

## 2. Baseline Performance Measurements

Baseline performance measurements were collected while the server was idle to provide a reference point for comparison with subsequent stress-testing results.

### 2.1 Commands Used

- `uptime`  
- `free -h`  
- `df -h /`  
- `vmstat 1 5`  

### 2.2 Baseline Results and Analysis

Baseline measurements showed a low system load, minimal memory usage, no swap utilisation, and moderate disk usage. CPU idle time remained high, indicating that the system was largely unused during baseline measurement.

These results establish a stable reference state against which changes observed during stress testing can be evaluated.

![Baseline performance measurements](../images/week6/baseline-performance.png)

**Figure 6.1:** Baseline system performance metrics collected under idle conditions.

---

## 3. CPU Performance Testing

### 3.1 Methodology

CPU stress testing was conducted using `stress-ng` to evaluate processor behaviour under sustained load. Four CPU workers were executed for 60 seconds to fully utilise the available CPU cores.

### 3.2 Command Used

```bash
stress-ng --cpu 4 --timeout 60s --metrics-brief
```

### 3.3 Results and Analysis

During testing, system load increased significantly, with the one-minute load average reaching approximately 2.85. CPU idle time dropped close to zero, confirming full utilisation of available CPU resources.

The system remained stable throughout the test and returned to idle conditions immediately after completion. This behaviour demonstrates effective CPU scheduling and load handling by the operating system under sustained computational demand.

![CPU stress test results](../images/week6/cpu-stress-test.png)

**Figure 6.2:** CPU utilisation and system load during stress-ng CPU testing.

---

## 4. Memory Performance Testing

### 4.1 Methodology

Memory stress testing was performed using `stress-ng` with two virtual memory workers configured to allocate **70%** of available system memory for 60 seconds.

### 4.2 Command Used

```bash
stress-ng --vm 2 --vm-bytes 70% --timeout 60s --metrics-brief
```

### 4.3 Results and Analysis

Memory usage increased from approximately **395 MiB** at baseline to over **420 MiB** during testing. Only minimal swap usage was observed, indicating that the system had sufficient physical memory to handle the workload without excessive paging.

The system remained responsive throughout the test, demonstrating stable memory management and effective handling of memory pressure.

![Memory stress test results](../images/week6/memory-stress-test.png)

**Figure 6.3:** Memory utilisation during stress-ng memory workload.

---

## 5. Disk I/O Performance Testing

### 5.1 Methodology

Disk I/O performance was evaluated using `fio` to simulate a random write workload. A **4 KB block size** was selected to reflect typical filesystem access patterns.

### 5.2 Command Used

```bash
fio --name=randwrite \
    --ioengine=libaio \
    --rw=randwrite \
    --bs=4k \
    --numjobs=1 \
    --size=1G \
    --runtime=60 \
    --time_based \
    --group_reporting
```
### 5.3 Results and Analysis

The disk achieved a sustained write throughput of approximately **118 MiB/s**, with over **30,000 IOPS** recorded during the test. Disk utilisation exceeded **88%**, indicating that storage performance became the primary system bottleneck under this workload.

Despite high utilisation, the system remained stable throughout the test, demonstrating reliable disk I/O handling under sustained write pressure.

![Disk I/O performance test results](../images/week6/disk-io-test.png)

**Figure 6.4:** fio random write benchmark results showing disk throughput and latency.

---

## 6. Network Performance Testing

### 6.1 Methodology

Network performance was measured using `iperf3` between the Windows host workstation and the Ubuntu Server over the isolated VirtualBox Host-only network.

### 6.2 Commands Used

**Server (Ubuntu Server):**

```bash
iperf3 -s
```

**Client (Windows workstation):**

```bash
iperf3 -c 192.168.56.101
```

### 6.3 Results and Analysis

The network performance test achieved a sustained throughput of approximately **3.43 Gbit/s** over a 10-second interval. Throughput remained stable throughout the test, with no packet loss observed.

These results demonstrate that the isolated VirtualBox Host-only network provides sufficient bandwidth for administrative access, monitoring, and performance testing. Network performance was therefore not a limiting factor during evaluation.

![Network performance test using iperf3](../images/week6/iperf3.png)

**Figure 6.5:** iperf3 network throughput results between the workstation and Ubuntu Server.

---

## 7. Performance Comparison Summary

| Metric               | Baseline | CPU Stress | Memory Stress | Disk I/O Stress | Network Test |
|----------------------|----------|------------|---------------|-----------------|--------------|
| Load average (1 min) | 0.02     | ~2.85      | Low           | Low             | N/A          |
| Memory usage         | 395 MiB  | ~400 MiB   | ~422 MiB      | ~420 MiB        | ~400 MiB     |
| Swap usage           | 0 B      | 0 B        | ~552 KiB      | 0 B             | 0 B          |
| Disk throughput      | Idle     | Idle       | Idle          | ~118 MiB/s      | Idle         |
| Network throughput   | Idle     | Idle       | Idle          | Idle            | ~3.43 Gbit/s |
| System stability     | Stable   | Stable     | Stable        | Stable          | Stable       |

---

## 8. Discussion

The system demonstrated predictable and stable behaviour across all tested workloads. CPU and memory resources scaled effectively under load, while disk I/O was identified as the primary performance constraint. Network performance exceeded requirements for remote administration and monitoring, confirming the suitability of the virtualised environment.

These findings highlight key operating system trade-offs between compute capacity, memory availability, and storage performance. While CPU and memory resources were sufficient for the tested workloads, disk performance represents a potential optimisation target for improving overall system responsiveness.

---

## 9. Conclusion

Week 6 successfully demonstrated systematic performance evaluation of an Ubuntu Server using industry-standard benchmarking tools. The results emphasise the importance of balanced resource provisioning and illustrate how operating system behaviour varies under different workload types.

The findings provide a strong foundation for optimisation analysis and informed configuration decisions in the final system evaluation phase.
