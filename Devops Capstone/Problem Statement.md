### **Automated CI/CD Pipeline for a Containerized Web Application on AWS**  

#### This project aims to set up an automated CI/CD pipeline using **Terraform** for infrastructure provisioning, **Ansible** for configuration management, and **Jenkins with Maven** for continuous integration and deployment.  
---

## **Task 1: Infrastructure Setup with Terraform**  

1. **Provision an Ansible Managed Node**  
   - Launch an **Ubuntu EC2 instance (t3.medium)** from the existing CI/CD EC2 instance using Terraform.  
   - This instance will act as the **Ansible Managed Node**.  

2. **Terraform Configuration**  
   - Create either a **single Terraform file** or **separate files** for:  
     - AWS **provider**  
     - **Key Pair** (generated using `ssh-keygen -t rsa`)  
     - **Security Group**: use the security group Id of the CICD machine. 
     - **EC2 Instance** configuration using the generated key pair.
     - Use the Ubuntu AMI-ID based on your region.

3. **Apply Terraform Code**  
   - Run Terraform commands to create the infrastructure and ensure SSH access from the CI/CD machine to the Ansible Managed Node.  

---
![image](https://github.com/user-attachments/assets/d788c659-5f4d-4573-929e-23c1f637a0cf)

## **Task 2: Configuration with Ansible**  

1. **Use the below Ansible Playbook to setup Jenkins & Docker on the managed node**  
   - Run the Playbook from the CI/CD machine.
```
---
- name: Start installing Jenkins pre-requisites before installing Jenkins
  hosts: all
  become: yes
  become_method: sudo
  gather_facts: no
  tasks:
  - name: Update apt repository with latest packages
    apt:
      update_cache: yes
      upgrade: yes
 
  - name: Installing jdk17 in Jenkins server
    apt:
      name: openjdk-17-jdk
      update_cache: yes
    become: yes
 
  - name: Installing jenkins apt repository key
    apt_key:
      url: https://pkg.jenkins.io/debian/jenkins.io-2023.key
      state: present
    become: yes
 
  - name: Configuring the apt repository
    apt_repository:
      repo: deb https://pkg.jenkins.io/debian binary/
      filename: /etc/apt/sources.list.d/jenkins.list
      state: present
    become: yes
 
  - name: Update apt-get repository with "apt-get update"
    apt:
      update_cache: yes

  - name: Finally, its time to install Jenkins
    apt: name=jenkins update_cache=yes
    become: yes
 
  - name: Jenkins is installed. Lets start 'Jenkins' now!
    service: name=jenkins state=started
 
 
  - name: Wait until the file /var/lib/jenkins/secrets/initialAdminPassword is present before continuing
    wait_for:
      path: /var/lib/jenkins/secrets/initialAdminPassword

  - name: You can find Jenkins admin password under 'debug'
    command: cat /var/lib/jenkins/secrets/initialAdminPassword
    register: out
  - debug: var=out.stdout_lines

  - name: install docker prerequisite packages
    apt:
      name: ['ca-certificates', 'curl', 'gnupg', 'lsb-release']
      update_cache: yes
      state: latest

  - name: Install the docker apt repository key
    apt_key: url=https://download.docker.com/linux/ubuntu/gpg state=present
    become: yes
 
  - name: Configure the apt repository
    apt_repository:
      repo: deb https://download.docker.com/linux/ubuntu bionic stable
      state: present
    become: yes
 
  - name: Install Docker packages
    apt:
      name: ['docker-ce', 'docker-ce-cli', 'containerd.io']
      update_cache: yes
    become: yes
 
  - name: Start Docker service
    service:
      name: docker
      state: started
      enabled: yes
 
  - lineinfile:
       dest: /lib/systemd/system/docker.service
       regexp: '^ExecStart='
       line: 'ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock'
 
 
  - name: Reload systemd
    command: systemctl daemon-reload
 
  - name: docker restart
    service:
      name: docker
      state: restarted
...
 ```
---

## **Task 3: Setup Jenkins and Docker**  
1. Ensure Jenkins & Docker are installed on the Managed node.
2. **Access Jenkins**  
   - Open Jenkins in a browser using the public IP of the managed node.  

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

Once complete, the setup will allow you to manually trigger a CI/CD pipeline, where Jenkins will fetch the code from the configured Github Repo, Maven will build it, and Docker will deploy the application.

