# Task 7 — Real-Time System Monitoring with Netdata (Docker)

## 📌 Overview
In this task, we deploy **Netdata** via Docker to monitor real-time system and container metrics.  
We explore CPU, memory, disk, network, Docker containers, alerts, and logs, then capture screenshots for submission.

---

## 🎯 Objective
- Install and run Netdata in a Docker container  
- Access the dashboard at **http://localhost:19999**  
- Explore and capture:
  - CPU usage
  - Memory usage
  - Disk & network activity
  - Docker container performance
  - Alerts & alarms
  - Logs from `/var/log/netdata`  

---

## 📂 Suggested Repo Structure
```
task7-netdata/
├─ README.md
├─ scripts/
│  └─ run_netdata.sh
└─ screenshots/
   ├─ 1 - Dashboard-Overview.png
   ├─ 2 - CPU-Memory.png
   ├─ 3 - Memory.png
   ├─ 4 - Disk-Network.png
   ├─ 5 - Containers-VM-CPU.png
   ├─ 6 - Containers-VM-CPU-Usage-Throttling.png
   ├─ 7 - Containers-VM-Memory.png
   ├─ 8 - Containers-VM-Memory-Usage-Activity.png
   ├─ 9 - Alert-Panel.png
   └─ 10 - Logs-Netdata.png
```

---

## 🛠️ Prerequisites
- Linux machine or VM with internet access  
- Docker installed and running

**Install Docker (Ubuntu/Debian):**
```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
# Re-login or run: newgrp docker
```

**Install Docker (RHEL/CentOS/Fedora):**
```bash
sudo dnf install -y docker docker-ce-cli containerd.io || sudo yum install -y docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
# Re-login or run: newgrp docker
```

---

## 🚀 Running Netdata

### Minimal Run Command (matches PDF instructions)
```bash
docker run -d --name=netdata -p 19999:19999 netdata/netdata
```

---

## 🌐 Accessing the Dashboard
- **Local machine:** http://localhost:19999  
- **Remote server:** http://<server-ip>:19999

If the firewall blocks the port:
```bash
# CentOS/RHEL/Fedora
sudo firewall-cmd --add-port=19999/tcp --permanent
sudo firewall-cmd --reload
```

---

## 📊 Exploring Metrics
1. **CPU Usage** — Utilization per core, load averages  
2. **Memory Usage** — Used vs free, cache, swap  
3. **Disk & Network** — I/O throughput, latency, errors  
4. **Docker Containers** — CPU/memory per container, throttling, activity  
5. **Alerts** — Triggered alarms with thresholds  
6. **Logs** — Inside container:
```bash
docker exec -it netdata ls -l /var/log/netdata
docker exec -it netdata tail -n 50 /var/log/netdata/error.log
```

---

## 📷 Screenshots 

### **📷 1 - Dashboard-Overview**
![1 - Dashboard-Overview](screenshots/1%20-%20Dashboard-Overview.png)

### **📷 2 -  CPU-Memory**
![2 -  CPU-Memory](screenshots/2%20-%20%20CPU-Memory.png)

### **📷 3 -  Memory**
![3 - Memory](screenshots/3%20-%20Memory.png)

### **📷 4 - Disk-Network**
![4 - Disk-Network](screenshots/4%20-%20Disk-Network.png)

### **📷 5 - Containers-VM's-CPU**
![5 - Containers-VM's-CPU](screenshots/5%20-%20Containers-VM's-CPU.png)

### **📷 6 - Containers-VM's-CPU-Usage-Throttling**
![6 - Containers-VM's-CPU-Usage-Throttling](screenshots/6%20-%20Containers-VM's-CPU-Usage-Throttling.png)

### **📷 7 - Containers-VM's-Memory**
![7 - Containers-VM's-Memory](screenshots/7%20-%20Containers-VM's-Memory.png)

### **📷 8 - Containers-VM's-Memory-Usage & Activity**
![8 - Containers-VM's-Memory-Usage & Activity](screenshots/8%20-%20Containers-VM's-Memory-Usage%20&%20Activity.png)

### **📷 9 - Alert-Panel**
![9 - Alert-Panel](screenshots/9%20-%20Alert-Panel.png)

### **📷 10 - Logs-Netdata**
![10 - Logs-Netdata](screenshots/10%20-%20Logs-Netdata.png)



---

## 🛠️ Troubleshooting
- **No charts or limited data:** Use the recommended run command (mounts `/proc`, `/sys`, etc.)  
- **Permission denied:** Run commands with `sudo` or add your user to the Docker group  
- **Port conflict:** Change mapping to `-p 29999:19999` and access `http://localhost:29999`  
- **No Docker metrics:** Ensure Docker is running; optionally mount `/var/run/docker.sock`

---

## 🔗 Related Work
I have also completed this same monitoring task using **Prometheus and Grafana**, a production-grade monitoring and visualization stack.  
You can check the full project here:  
📎 **[Prometheus + Grafana Monitoring Project](https://github.com/Sohel9146/Task-7-Promethious-Grafana-Monitoring.git)**

In addition, I have implemented multiple projects using Prometheus and Grafana for system monitoring, container tracking, and real-time alerting.

---

## 💬 Interview Q&A

**1. What does Netdata monitor?**  
Netdata monitors **real-time performance metrics** from **systems, containers, applications, and services**, including **CPU**, **memory**, **disk I/O**, **network traffic**, **running processes**, and **health alarms**.

**2. How do you view real-time metrics?**  
Access Netdata’s **interactive dashboard** in a web browser at:  
- **Local:** `http://localhost:19999`  
- **Remote:** `http://<server-ip>:19999`

**3. What is a collector?**  
A **collector** is a **plugin/module** in Netdata that **gathers metrics** from a specific source (e.g., **OS**, **Docker**, **Nginx**, **MySQL**) and feeds them to the **dashboard**.

**4. How is Netdata different from Prometheus?**  
- **Netdata**: **Plug-and-play**, **instant per-second dashboards**, **built-in alerting**, **no complex setup**.  
- **Prometheus**: **Metrics storage and querying engine**, requires **exporters** for collection and **Grafana** for visualization.

**5. What are some performance KPIs to watch?**  
- **CPU utilization per core**  
- **Memory usage** (used, cache, swap)  
- **Disk I/O throughput & latency**  
- **Network throughput & error rates**  
- **Container CPU/memory usage & throttling**

**6. How to deploy Netdata on a VM?**  
Install **Docker**, then run:  
```bash
docker run -d --name=netdata -p 19999:19999 netdata/netdata
Access the dashboard via the VM’s IP and port.

**7. How does Netdata alerting work?**  
Netdata has **built-in health checks** with **predefined thresholds**; when a **metric crosses the limit**, it **triggers an alarm** and can **notify via email, Slack, Discord**, or other supported channels.

**8. What is a dashboard in this context?**  
A **dashboard** is Netdata’s **web-based visual interface** that displays **live metrics** in **interactive charts**, allowing you to **drill down** from **system overviews** to **individual processes**.


