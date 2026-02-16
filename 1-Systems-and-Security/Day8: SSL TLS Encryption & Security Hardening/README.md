# 🔐 Day 08: SSL/TLS Encryption & Security Hardening

## 📖 Project Overview

On Day 08, I secured application traffic by migrating from HTTP (Port 80) to HTTPS (Port 443).

Using OpenSSL, I generated a self-signed SSL certificate and configured Nginx to perform SSL termination. All external traffic is encrypted before being proxied to the backend Python application running on an internal port.

This demonstrates secure traffic handling at the edge layer.

---

## 🏗️ Architecture Flow

Client (Browser)  
↓ HTTPS (Port 443 – Encrypted)  
Nginx (SSL Termination)  
↓ Internal HTTP  
Python Backend (Port 8080)

- Public traffic is encrypted.
- Backend service remains internally isolated.

---

## 🛠️ Technical Implementation

### 1️⃣ SSL Certificate Generation

Generated a 4096-bit RSA private key and self-signed certificate using OpenSSL:

```bash
openssl req -x509 -newkey rsa:4096 \
-keyout key.pem \
-out cert.pem \
-nodes \
-days 365
```

- Private Key: Used for decryption  
- Certificate Type: Self-signed X.509  
- Validity: 365 days  

---

### 2️⃣ Nginx SSL Configuration

File:
```
/etc/nginx/conf.d/proxy.conf
```

```nginx
server {
    listen 443 ssl;
    ssl_certificate /etc/nginx/ssl/cert.pem;
    ssl_certificate_key /etc/nginx/ssl/key.pem;

    location / {
        proxy_pass http://127.0.0.1:8080;
    }
}

server {
    listen 80;
    return 301 https://$host$request_uri;
}
```

### Implemented Concepts

- SSL Termination
- Reverse Proxy Integration
- HTTP to HTTPS Enforcement
- 301 Permanent Redirect

---

## 🔍 Troubleshooting

### Browser “Connection Not Private” Warning

Because the certificate is self-signed and not issued by a trusted Certificate Authority, the browser displays a warning.

Important:
- Encryption is active.
- Data transmission is secure.
- Only identity verification is untrusted.

---

### HTTPS Timeout Issue

**Root Cause:**  
Port 443 was blocked at the cloud firewall level.

**Fix:**  
Updated AWS Security Group to allow:

- Type: HTTPS  
- Protocol: TCP  
- Port: 443  
- Source: 0.0.0.0/0  

---

## 📸 Project Proof

### 🔹 HTTPS Enabled
![HTTPS Working](screenshots/https-working.png)

### 🔹 Nginx SSL Configuration
![Nginx SSL Config](screenshots/nginx-ssl-config.png)

### 🔹 HTTP to HTTPS Redirect
![Redirect](screenshots/http-redirect.png)

### 🔹 Security Group (Port 443 Open)
![Security Group](screenshots/security-group-443.png)

---

## ✅ Verification Results

- Visiting `http://<EC2-IP>` automatically redirects to HTTPS.
- TLS encryption is active.
- RSA 4096-bit certificate in use.
- Secure traffic successfully proxied to backend service.

