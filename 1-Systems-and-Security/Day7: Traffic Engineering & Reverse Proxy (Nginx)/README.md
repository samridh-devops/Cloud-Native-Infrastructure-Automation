# 🛡️ Day 07 – Traffic Engineering & Reverse Proxy (Nginx)

## 📌 Project Overview
On Day 07, I transitioned from serving static HTML content to managing live application traffic using a Reverse Proxy architecture.

I configured Nginx to act as a high-performance front layer that forwards incoming HTTP requests to an internal backend application running on a private port.

This project demonstrates:
- Reverse Proxy configuration
- Traffic routing & request forwarding
- Application isolation
- Nginx configuration management
- Real-world troubleshooting

---

## 🏗️ Architecture Overview

**Cloud Provider:** AWS  
**Compute:** Amazon EC2 (Amazon Linux 2023)  
**Frontend Layer:** Nginx (Port 80)  
**Backend Application:** Python HTTP Server (Port 8080)  

Flow:

Client → Nginx (Port 80) → Proxy Pass → Python App (127.0.0.1:8080)

The backend service is not publicly exposed.

---

## 📸 Project Proof

### 🔹 Reverse Proxy Working (Public Access)
![Reverse Proxy Output](https://github.com/samridh-devops/Cloud-Native-Infrastructure-Automation/blob/381c3d2fd5f07fb088e925d78bae232a5ba4ce80/1-Systems-and-Security/Day7%3A%20Traffic%20Engineering%20%26%20Reverse%20Proxy%20(Nginx)/screenshort/Reverse_Proxy_Output.png)

### 🔹 Backend Python Server Running (Port 8080)
![Python Backend](https://github.com/samridh-devops/Cloud-Native-Infrastructure-Automation/blob/381c3d2fd5f07fb088e925d78bae232a5ba4ce80/1-Systems-and-Security/Day7%3A%20Traffic%20Engineering%20%26%20Reverse%20Proxy%20(Nginx)/screenshort/Python%20Backend.png)


### 🔹 Nginx Proxy Configuration Test
![Nginx Test](https://github.com/samridh-devops/Cloud-Native-Infrastructure-Automation/blob/381c3d2fd5f07fb088e925d78bae232a5ba4ce80/1-Systems-and-Security/Day7%3A%20Traffic%20Engineering%20%26%20Reverse%20Proxy%20(Nginx)/screenshort/Nginx%20Proxy%20Config.png)

---

## ⚙️ Technical Implementation

---

### 1️⃣ Backend Application (Python Microservice)

Simulated backend service:

```bash
python3 -m http.server 8080
```

Internal Port:
```
8080
```

This service listens only on localhost and is not directly exposed to the internet.

---

### 2️⃣ Nginx Reverse Proxy Configuration

File:
```
/etc/nginx/conf.d/proxy.conf
```

Configuration:

```nginx
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:8080;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

---

### 3️⃣ Deployment & Validation Steps

Validate Nginx configuration:

```bash
sudo nginx -t
```

Restart Nginx:

```bash
sudo systemctl restart nginx
```

Verify backend logs:
Python terminal logs incoming `GET` requests from 127.0.0.1.

---

## 🔎 Troubleshooting

### Issue: Browser Still Showing Old Static Page

Root Cause:
Default Nginx server block was overriding proxy configuration and serving content from:

```
/usr/share/nginx/html
```

Resolution:
1. Removed or commented default server block in `/etc/nginx/nginx.conf`
2. Restarted Nginx
3. Performed Hard Refresh (Ctrl + F5)
4. Verified Python backend logs were receiving requests

---

## 🧠 Why Reverse Proxy Matters (DevOps Best Practices)

### 🔐 Security
Backend application remains isolated. Only Nginx is publicly exposed.

### 📈 Scalability
Can extend this setup to:
- Load balancing multiple backend instances
- Traffic distribution strategies

### 🔒 SSL Termination
HTTPS encryption can be handled at the Nginx layer, reducing backend CPU load.

---

## 🌍 Public Access

Access via:

```
http://<EC2-PUBLIC-IP>
```

Expected Output:

```
Hello World from the Backend App on Port 8080!
```

---

## 🎯 Outcome

Static Content Serving → Reverse Proxy Traffic Engineering

This project validates:
- Real-world reverse proxy implementation
- Internal service isolation
- Production-style Nginx configuration
- Debugging configuration precedence issues
- Understanding of layered application architecture

