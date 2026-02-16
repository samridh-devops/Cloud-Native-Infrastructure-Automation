# 🚀 Day 06 – Infrastructure Automation & Live Status Dashboard

## 📌 Project Summary
On Day 06, I automated infrastructure monitoring by transforming an Amazon EC2 instance into a self-updating live status dashboard.

This project demonstrates:
- Linux system administration
- Nginx web server configuration
- Bash automation scripting
- Cron-based job scheduling
- AWS cloud networking troubleshooting

---

## 🏗️ Architecture Overview

**Cloud Provider:** AWS  
**Compute:** Amazon EC2 (Amazon Linux 2023)  
**Web Server:** Nginx  
**Automation:** Bash + Cron  
**Networking:** AWS Security Groups (HTTP Port 80)

Flow:

Linux Kernel → Bash Script → Dynamic HTML → Nginx → Public Browser Access

---

## 📸 Project Proof


### 🔹 Live Dashboard (Public Access)
![EC2 Instance](https://raw.githubusercontent.com/samridh-devops/Cloud-Native-Infrastructure-Automation/main/1-Systems-and-Security/Day6%3AInfra-Automation/screenshort/ec2-instance.png)


### 🔹 Cron Job Automation
![Cron Job](https://github.com/samridh-devops/Cloud-Native-Infrastructure-Automation/blob/d605497ef46896a0eed7b9dddb12e2d3878dc6fa/1-Systems-and-Security/Day6%3AInfra-Automation/screenshort/update_status.png)

---

## ⚙️ Technical Implementation

### 1️⃣ Nginx Setup

```bash
sudo dnf install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl status nginx
```

Configuration file:
```
/etc/nginx/nginx.conf
```

Document root:
```
/usr/share/nginx/html/index.html
```

---

### 2️⃣ Automation Script (`update_status.sh`)

```bash
#!/bin/bash

TARGET_FILE="/usr/share/nginx/html/index.html"

UPTIME_INFO=$(uptime -p)
TIMESTAMP=$(date)

cat <<EOF > temp_index.html
<html>
<body style="font-family: Arial; text-align: center; background: #f4f4f4;">
    <div style="margin-top: 50px; background: white; display: inline-block; padding: 20px; border-radius: 10px; border: 1px solid #ddd;">
        <h1 style="color: #333;">DevOps Day 6: Status Page</h1>
        <p><strong>Engineer:</strong> Samridh Gupta</p>
        <p><strong>Server Status:</strong> <span style="color: #27ae60;">$UPTIME_INFO</span></p>
        <hr>
        <p style="color: gray; font-size: 0.8em;">Last Updated: $TIMESTAMP</p>
    </div>
</body>
</html>
EOF

sudo mv temp_index.html $TARGET_FILE
```

Make executable:
```bash
chmod +x update_status.sh
```

---

### 3️⃣ Cron Job Scheduling

Edit crontab:

```bash
crontab -e
```

Add:

```
* * * * * /home/ec2-user/update_status.sh
```

Execution Frequency: Every 60 seconds.

---

## 🔎 Troubleshooting

### Issue: `crontab -e` command not found

```bash
sudo dnf install cronie -y
sudo systemctl enable --now crond
```

### Issue: "This site can’t be reached"

Resolution:
- Opened Port 80 in AWS Security Group
- Verified Nginx service is running

---

## 🌍 Live Endpoint

```
http://<EC2-PUBLIC-IP>
```

---

## 🎯 Outcome

Manual Server Management → Automated Self-Updating Infrastructure

This project validates:
- Infrastructure deployment on AWS
- Automation using Bash
- Public service exposure
- Cloud networking configuration
- Production-style troubleshooting
