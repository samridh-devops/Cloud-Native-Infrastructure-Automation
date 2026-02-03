# Day 2 :  Linux Permissions & Ownership Lab

## **Project Overview**
Welcome to Day 2! Today's focus is on securing the file system. You will learn how to create users, transfer ownership of directories, and lock down access using octal permissions.

---

## **Technical Tasks Executed**

### **Step 1: Create the "Target" User**
First, we create a new user named **devops**. This simulates adding a new team member to your server.

- **Command:** sudo adduser devops
- **Outcome:** shown in screenshort
### **Sceernshot**
![System Audit Output](https://github.com/samridh-devops/Cloud-Native-Infrastructure-Automation/blob/c2173dab0ac08abcf4a1eb94c5486d40c0a186a4/1-Systems-and-Security/Day-01-CLI-Mastery/screenshots/d2a.png)
---------------------------
### **Step 2: Create the Private Directory**
Now, we create a folder that we intend to keep secret.

- **Command:** `sudo mkdir /private_dir
- **Explanation:** By default, folders created with sudo are owned by the root user. We will change this in the next step so our devops user can manage it.

--------------------------
### **Step 3: Change Ownership (The "Who")**
We will now transfer ownership of that folder from root to devops**
I developed a Bash script (`audit.sh`) to provide a quick health snapshot of the EC2 instance.
- **Command:** sudo chown devops:devops /private_dir
- **Explanation:** chown stands for CHange OWNer.
- **The Syntax:** user:group. Here, we are making the user devops the owner and the group devops the group-owner.

--------------------------
### **Step 4: Master the Permissions**
(The "What")This is the most critical part. We use chmod (Change Mode) to set the 700 permission.
- **The Syntax:** sudo chmod 700 /private_dir

--------------------------
### **Step 5: Create a Secret File**
Let's put something inside that folder specifically as the devops user.

- **The Syntax:** sudo -u devops touch /private_dir/secret.txt
- **Explanation:** sudo -u devops tells the system: "Run this command specifically as the user devops."
### **Sceernshot**
![System Audit Output](https://github.com/samridh-devops/Cloud-Native-Infrastructure-Automation/blob/c2173dab0ac08abcf4a1eb94c5486d40c0a186a4/1-Systems-and-Security/Day-01-CLI-Mastery/screenshots/d2b.jpg)

--------------------------
### **Step 6: The "Permission Denied" Test (The Proof)**
Now, try to look inside that folder using your default account (e.g., ubuntu).

- **The Syntax:** ls /private_dir
- **Expected Result:** ls: cannot open directory '/private_dir': Permission denied

--------------------------

