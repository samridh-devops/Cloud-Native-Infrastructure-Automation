# Day 02: Linux Permissions & Ownership (IAM)

## 🎯 Project Objective
The goal of Day 2 was to master **Linux Security Fundamentals**. In DevOps, we use the "Principle of Least Privilege" to ensure that users and automated services only have the exact access they need to perform their jobs, preventing unauthorized data access or accidental system changes.

---

## 🛠️ Technical Concepts Mastered

### **1. Permission Structure (UGO)**
Linux divides permissions into three distinct layers:
* **User (u):** The individual owner of the file.
* **Group (g):** Multiple users assigned to a specific group with shared access.
* **Others (o):** Every other user on the system (the world).

### **2. Numeric (Octal) Notation**
I used the octal system to set precise permissions based on bitmask values:
* **4** = Read (r)
* **2** = Write (w)
* **1** = Execute (x)
* **0** = No Access (-)

> **Example:** `700` means the **Owner** has 7 (4+2+1), while **Group** and **Others** get 0 (No access).

---

## 💻 Practical Implementation (Ubuntu CLI)

### **Step 1: Identity Creation**
I created a new system user named `devops` to simulate a team member environment.
```bash
sudo adduser devo
-------
### **Step 2: Data Isolation (The "Silo" Method)**
I created a high-security directory and transferred ownership to the new user to ensure total data isolation.

```Bash
# 1. Create the directory
sudo mkdir /private_dir

# 2. Change Ownership (The "Who")
sudo chown devops:devops /private_dir

# 3. Apply Strict Permissions (The "What")
sudo chmod 700 /private_dir
