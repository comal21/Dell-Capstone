

## **Step 1: Infrastructure Setup with Terraform**  

### **1.1 Create a Key Pair**  
Generate a key pair using `ssh-keygen`:  
```bash
ssh-keygen -t rsa 
```

---

### **1.2 Create Terraform Files**  
Create the following Terraform files:  

1. **Provider Configuration** (`provider.tf`)  
```hcl
provider "aws" {
  region = "us-east-1"
}
```

2. **Key Pair** (`key_pair.tf`)  
```hcl
resource "aws_key_pair" "mykeypair" {
  key_name   = var.key_name
  public_key = file(var.public_key)
}
```

3. **EC2 Instance** (`instance.tf`)  
```hcl
resource "aws_instance" "my-machine" {
  ami                    = var.ami_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.sg_id]
  instance_type          = var.ins_type

  tags = {
    Name = "my-instance"
  }
}
```

4. **Variables** (`vars.tf`)  
```hcl
# Change the SG ID. You can use the same SG ID used for your CICD anchor server
# Basically the SG should open ports 22, 80, 8080, 9999, and 4243
variable "sg_id" {
    default = "sg-05129de194fe9156f" # us-east-1
}

# Choose a free tier Ubuntu AMI. You can use below. 
variable "ami_id" {
    default = "ami-0866a3c8686eaeeba" # us-east-1; Ubuntu
}

# We are only using t2.micro for this lab
variable "ins_type" {
    default = "t2.medium"
}

# Replace 'yourname' with your first name
variable "key_name" {
    default = "YourName-CICDlab-KeyPair"
}

variable "public_key" {
    default = "/home/ubuntu/.ssh/id_rsa.pub"   #Ubuntu OS
}
```

---

### **1.3 Apply Terraform Code**  
1. Initialize Terraform:  
```bash
terraform init
```
2. Plan the deployment:  
```bash
terraform plan
```
3. Apply the configuration:  
```bash
terraform apply -auto-approve
```

---

## **Step 2: Configuration with Ansible**  

1. **Update the host-file with the EC2 instance IP address**  
```bash
sudo vi /etc/ansible/hosts
```
2. Paste the Public IP of the EC2 instance and save the file.  

3. **SSH into the Instance**  
```bash
ssh ubuntu@<IP-address>
```

4. **Create an Ansible playbook**  
```bash
vi ansible-script.yaml
```

