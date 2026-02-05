# Day 03: Automation & Self-Healing Systems

## 📖 Overview
Today, I transitioned from manual administration to **Automated Infrastructure Management**. I built a "Self-Healing" script that monitors the Nginx web server and automatically restores service if a failure is detected. This is a core practice in **Site Reliability Engineering (SRE)**.

---

## 🛠️ Step-by-Step Implementation

### **Step 1: Script Development**
Using `nano`, I created a Bash script to monitor the system state. I used `systemctl is-active` for precise service tracking.



--------


### **Step 2: Permissions & Automation**
To make the script functional, I updated the file permissions and scheduled it to run every minute using **Cron**.

1. **Make the script executable:**
   ```bash
   chmod +x monitor_nginx.sh
----

### **Step 3: Verification & Monitoring**
To verify the self-healing system, I simulated a service failure and monitored the logs to confirm the script successfully detected and fixed the issue.

bash
 1. **Manually stop the service to trigger the script**
     ```bash
    sudo systemctl stop nginx

 2. **Check the logs for the recovery alert**
      ```bash
      tail -f /var/log/sys_check.log

3. **Confirm Nginx is back online**
     ```bash
     systemctl status nginx

---

### **Step 4: Reflections & Key Takeaways**
This project demonstrates the transition from manual troubleshooting to **automated resilience**.

*   **Automation is Key:** Instead of waiting for a user to report a site is down, the system fixes itself in under 60 seconds.
*   **Observability:** By logging every restart to `/var/log/sys_check.log`, I created an audit trail that helps identify if service instability is becoming a recurring trend.
*   **Scalability:** This logic can be expanded to monitor databases (MySQL/PostgreSQL), disk space, or memory usage.

---
**Day 03 complete!** 

