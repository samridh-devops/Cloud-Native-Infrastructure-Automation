## Day 05: Networking & Port Infrastructure

## 📖 Overview
Today, I mastered the "Nervous System" of the server. I moved beyond the OS layer to explore the **Transport Layer (L4)** and **Network Layer (L3)**. I learned how to audit open ports, identify process ownership, and trace the path of data from the Root DNS servers to a final IP address.

---

## 🛠️ Tactical Implementation

### **Task 1: The "Manual Handshake" (Socket Talk)**
You must prove you can move data between two processes without a web server.
### *1.	Open two terminal windows (SSH into your EC2 twice).*
### *2.	Initializing the Listener (The Server)*
In the first terminal session, I initiated a listener on a non-privileged port (8888). This process enters a LISTEN state, waiting for an incoming TCP connection.


* -l tells netcat to listen for a connection
* **nc -l 8888Terminal 1 (The Listener):** Run nc -l 8888.

### *3. Establishing the Connection (The Client)*
In a second terminal session, I acted as the client. By initiating a connection to the local loopback address (`127.0.0.1`) on the designated port, I triggered the operating system to begin the network handshake.

bash
# Connecting to the local machine on port 8888
nc 127.0.0.1 8888

----

### **Task 2: Egress Connectivity Testing**
Objective
To verify that the server's Egress (outbound) network rules are correctly configured. In a DevOps lifecycle, a server must reach external APIs, download security patches, and communicate with external repositories through the AWS Internet Gateway.

1. Execution & Command
Using the public IP address of Google resolved in the previous DNS trace (142.251.220.46), I performed a manual TCP probe.

Probing Google's public IP on the standard HTTPS port
### *nc -zv 142.251.220.46 443*
Observation: The command returned Connection to 142.251.220.46 443 port [tcp/https] succeeded!. This confirms that the TCP Three-Way Handshake was completed successfully between my EC2 instance and a public external entity.

2. Forensic Analysis: Why Port 443 vs. Port 80?
In a technical interview, I would justify the use of Port 443 for this test based on three core engineering principles:

Encryption Standard: Port 443 is used for HTTPS. In 2026, standard HTTP (Port 80) is considered insecure and is often blocked by default in enterprise "Secure-by-Design" environments.

Traffic Validation: Most modern web services automatically redirect Port 80 traffic to Port 443. By testing 443 directly, I am testing the actual service port rather than a redirect service.

Firewall/Security Group Egress: Often, security teams only allow outbound traffic on 443 to limit the attack surface. Testing this port ensures the server complies with standard security policies while still maintaining connectivity.

----

### **Task 3: The Troubleshooting Log (Post-Mortem)**
Incident Report: Service Discovery Failure
Date: 2026-02-09

Service: Nginx Web Server 

Severity: High (Service Down)

1. **The Problem (What happened?)**
During a routine network audit to verify web accessibility, the system was unable to locate the Nginx service. Attempting to start the service resulted in the following error:

Failed to start nginx.service: Unit nginx.service not found.

2. **Detection & Diagnosis (How did I find it?)**
I utilized a systematic troubleshooting approach to identify the failure point:

Networking Layer: Ran sudo lsof -i -P -n | grep LISTEN. I noticed Port 80 was missing from the output, indicating no process was binding to the HTTP port.

System Layer: Ran sudo systemctl status nginx. The system confirmed the unit file was missing entirely, proving that the issue wasn't just a stopped service, but a missing installation.

3. **Resolution (How did I fix it?)**
Since the package was missing from the Amazon Linux 2023 environment, I performed the following recovery steps:

Installation: Updated the package repository and installed Nginx via sudo dnf install nginx -y.

Initialization: Started the service using sudo systemctl start nginx.

Persistence: Enabled the service to ensure it starts automatically on system reboots using sudo systemctl enable nginx.

Verification: Confirmed the fix by re-running the lsof audit, which then showed Nginx successfully listening on Port 80.

4. **Lessons Learned**
Verification over Assumption: Never assume an image or AMI comes with all required software pre-installed.

Audit-Driven Development: Using networking tools like lsof and ss is the fastest way to detect application failures before they are reported by users.

-----

### 🛠️ Tasks Completed
1. **Service Recovery:** Diagnosed a missing Nginx unit, installed the package via `dnf`, and verified the service was `LISTEN`ing on Port 80.
2. **Network Auditing:** Used `lsof -i -P -n` to map PIDs to network sockets.
3. **Socket Communication:** Established a manual TCP connection between two terminal sessions using `nc` (Netcat) to understand raw data transmission.

### 🔍 Key Findings
* **Privileged Ports:** Observed Nginx Master process running as `root` to bind to Port 80.
* **Loopback vs Public:** Verified that internal services bound to `127.0.0.1` are unreachable from external IPs, a critical security boundary.

### 🧪 Troubleshooting Log
* **Issue:** `Unit nginx.service could not be found.`
* **Solution:** Installed `nginx` package.
* **Verification:** `nc -zv 127.0.0.1 80` confirmed successful TCP handshake.
