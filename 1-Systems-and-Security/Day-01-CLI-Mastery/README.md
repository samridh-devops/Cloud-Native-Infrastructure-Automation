# Day 1: Linux CLI Mastery & Cloud Audit Automation

## **Project Overview**
On Day 1, I initialized my DevOps environment on an **AWS EC2 (Ubuntu 24.04)** instance. The focus was on mastering the command-line interface (CLI), automating log maintenance, and creating a system health monitoring tool.

---

## **Technical Tasks Executed**

### **1. Infrastructure Workspace Setup**
Instead of using the root home directory, I established a structured workspace to mimic production environments.
- **Command:** `mkdir -p ~/projects/web-server/{logs,src,config,scripts}`
- **Outcome:** Created a recursive directory tree for better project organization.
### **Sceernshot
----------------------------
### **2. Automated Log Cleanup (Log Rotation Simulation)**
Managing disk space is a critical DevOps responsibility. I simulated a scenario where old logs fill up the disk and used the `find` utility to automate cleanup.
- **Simulation:** Created "junk" files with artificial timestamps using `touch -d`.
- **The Filter:** `find ~/projects/web-server/logs -type f -mtime +7`
- **The Purge:** `find ~/projects/web-server/logs -type f -mtime +7 -delete`
- **Result:** Successfully identified and removed only the files older than 7 days, preserving current logs.
### **Sceernshot
--------------------------
### **3. AWS System Audit Script**
I developed a Bash script (`audit.sh`) to provide a quick health snapshot of the EC2 instance.

**Key features of the script:**
- Fetches the **Public IP** using `curl`.
- Displays **Memory Usage** in human-readable format.
- Monitors **Disk Partitions** to prevent overflow.

---

## **Sample Script Output**
```text
==============================
     AWS EC2 AUDIT REPORT
==============================
Public IP: 3.110.41.192
Memory Usage: 353Mi used / 957Mi total
Disk Usage: /dev/root (27% full)
Audit completed at: Tue Feb 3 13:12:47 UTC 2026
