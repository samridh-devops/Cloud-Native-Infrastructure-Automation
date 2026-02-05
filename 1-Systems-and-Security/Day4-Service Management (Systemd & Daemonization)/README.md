# Day 04: Service Management (Systemd & Daemonization)
## 📖 Overview
Today, I moved from running scripts manually to managing System Services. I learned that in production, automation must be persistent. I transformed my "Self-Healing" script into a native Linux Daemon using systemd, ensuring that my Nginx monitor is always running, even after a system reboot.

---

## 🛠️ Step-by-Step Implementation
## **Step 1: Creating the Unit File**
I defined a custom service unit file in /etc/systemd/system/. This file tells the Linux kernel how to treat my script as a background service.

Bash
sudo nano /etc/systemd/system/monitor.service
Unit File Configuration:

Ini, TOML
[Unit]
Description=Nginx Self-Healing Monitor
After=network.target nginx.service

[Service]
Type=simple
ExecStart=/home/ec2-user/nginx_monitor.sh
Restart=always
RestartSec=60
User=ec2-user

[Install]
WantedBy=multi-user.target

## **Step 2:Enabling Persistence
* 1.Unlike a manual script, a service can be "enabled" to start automatically during the boot sequence.

* 2.Reload the system manager:

   sudo systemctl daemon-reload

* 3.Enable for boot-start:

  sudo systemctl enable monitor.service

* 4.Start the process:

  sudo systemctl start monitor.service
---

## **Step 3:The Persistence Test
The ultimate test of a System Engineer is a Reboot.
* 1.	Check Status: systemctl status monitor.service
* 2.	Reboot the Instance: sudo reboot
* 3.	Wait 1 minute, reconnect via SSH/EC2 Connect, and check again:
Bash
systemctl status monitor.service
o	Goal: The status should say active (running) without you touching anything!

 ---
**Day 03 complete!** 
