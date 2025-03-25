Step 1: Infrastructure Setup with Terraform
1.1 Create a Key Pair
Generate a key pair using ssh-keygen:

ssh-keygen -t rsa 
1.2 Create Terraform Files
Create the following Terraform files:

Provider Configuration (provider.tf)
provider "aws" {
  region = "us-east-1"
}
Key Pair (key_pair.tf)
resource "aws_key_pair" "mykeypair" {
  key_name   = var.key_name
  public_key = file(var.public_key)
}
EC2 Instance (instance.tf)
resource "aws_instance" "my-machine" {
  ami                    = var.ami_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.sg_id]
  instance_type          = var.ins_type

  tags = {
    Name = "my-instance"
  }
}
Variables (vars.tf)
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
1.3 Apply Terraform Code
Initialize Terraform:
terraform init
Plan the deployment:
terraform plan
Apply the configuration:
terraform apply -auto-approve
Step 2: Configuration with Ansible
Update the host-file with the EC2 instance IP address
sudo vi /etc/ansible/hosts
Paste the Public IP of the EC2 instance and save the file.

SSH into the Instance

ssh ubuntu@<IP-address>
Create an Ansible playbook
vi ansible-script.yaml
