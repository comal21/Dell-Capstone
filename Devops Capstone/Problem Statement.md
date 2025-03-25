### **Automated CI/CD Pipeline for a Containerized Web Application on AWS**  

This project aims to set up an automated CI/CD pipeline using **Terraform** for infrastructure provisioning, **Ansible** for configuration management, and **Jenkins with Maven** for continuous integration and deployment.  
---

## **Task 1: Infrastructure Setup with Terraform**  

1. **Provision an Ansible Control Node**  
   - Launch an **Ubuntu EC2 instance (t3.medium)** from an existing CI/CD EC2 instance using Terraform.  
   - This instance will act as the **Ansible Control Node**.  

2. **Terraform Configuration**  
   - Create either a **single Terraform file** or **separate files** for:  
     - AWS **provider**  
     - **Key Pair** (generated using `ssh-keygen`)  
     - **Security Group** with the following rules:  
       - **Inbound:** Ports `22`, `80`, `443`, `8080`, `9999`  
       - **Outbound:** All traffic  
     - **EC2 Instance** configuration using the generated key pair.  

3. **Apply Terraform Code**  
   - Run Terraform commands to create the infrastructure and ensure SSH access from the CI/CD machine to the Ansible Control Node.  

---

## **Task 2: Configuration with Ansible**  

1. **Install Essential Packages on the Ansible Control Node**  
   - Install and set up:  
     - **Ansible**  
     - **AWS CLI**  
     - **Python**  
     - **AWS Configure** (for AWS authentication)  

2. **Setup Jenkins & Docker**  
   - Install and configure **Jenkins** and **Docker** using Ansible.  

3. **Configure Ansible for Local Execution**  
   - Since there are no separate managed nodes, configure Ansible to use the control node as its own managed node:  
     - Create an **inventory file** at `/etc/ansible/hosts`.  
     - Add the following line:  
       ```
       localhost ansible_connection=local
       ```  

---

## **Task 3: Setup Jenkins and Docker**  

1. **Deploy Jenkins and Docker on the Control Node**  
   - Use Ansible to install and configure **Jenkins** and **Docker** on the same machine.  

2. **Access Jenkins**  
   - Open Jenkins in a browser using the public IP of the control node.  

3. **Configure Maven in Jenkins**  
   - Install the **Maven plugins** in Jenkins.  
   - Add **Maven tool** in Jenkins settings.  

4. **Set Up a Maven Project in Jenkins**  
   - Create a **new Maven project** in Jenkins.  
   - Use the following GitHub repository:  
     ```
     https://github.com/comal21/my-app
     ```  
   - Configure Jenkins to:  
     - **Manually trigger the build** (`Build Now` button).  
     - **Pull the latest code** from GitHub.  
     - **Use Maven** to build the application.  
     - **Deploy the application using Docker**.  

---

Once complete, the setup will allow you to manually trigger a CI/CD pipeline, where Jenkins will fetch the latest code, Maven will build it, and Docker will deploy the application.
