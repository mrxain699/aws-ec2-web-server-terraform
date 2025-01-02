# AWS EC2 WEB SERVER Infrastructure with Terraform

This project defines an AWS web server infrastructure setup using Terraform. The configuration includes an EC2 instance running Ubuntu, with a security group allowing HTTP, HTTPS, and SSH access. Additionally, the instance is configured to install and run Nginx automatically.

## Prerequisites

- **Terraform**: Ensure you have Terraform version `1.10.3` or later installed.
- **AWS CLI**: Install and configure the AWS CLI with appropriate credentials.
- **SSH Key Pair**:
  - A public key located at `~/.ssh/id_rsa.pub`.
  - A private key located at `~/.ssh/id_rsa_tf`.
- **Graphviz** (optional): For generating dependency graphs with `terraform graph`.

## Resources Created

1. **AMI**: Fetches the latest Ubuntu AMI based on provided filters.
2. **EC2 Instance**:
   - Instance type: `t2.micro`
   - Ubuntu 24.04
   - Automatically installs and configures Nginx.
3. **Key Pair**: Adds an existing SSH public key to AWS for secure access or generate the new one.
4. **Security Group**: Configures inbound rules for HTTP (port 80), HTTPS (port 443), and SSH (port 22).
5. **Ingress and Egress Rules**:
   - Ingress rules allow specific traffic as defined in `security_group_rules`.
   - Egress rule allows all outbound traffic.

## Variables

### Input Variables

| Variable                  | Type   | Description                               |
| ------------------------- | ------ | ----------------------------------------- |
| `instance_detail`         | Map    | Details about the instance configuration. |
| `instance_kp`             | Map    | Details about the key pair.               |
| `instance_security_group` | Map    | Details about the security group.         |
| `security_group_rules`    | Map    | Ingress rules for the security group.     |
| `public_key_path`         | String | Path to the SSH public key.               |
| `private_key_path`        | String | Path to the SSH private key.              |

## Usage

1. **Initialize Terraform**:

   ```bash
   terraform init
   ```

2. **Validate Configuration Syntax**:

   ```bash
   terraform validate
   ```

3. **Plan the Infrastructure**:

   ```bash
   terraform plan
   ```

4. **Apply the Configuration**:

   ```bash
   terraform apply --auto-approve
   ```

5. **Check Logs**:
   Logs for the instance creation are written to `instance.log`.

6. **Access the EC2 Instance**:
   Use the private key to SSH into the instance:
   ```bash
   ssh -i ~/.ssh/id_rsa ubuntu@<instance_public_ip>
   ```

## Additional Commands

- **Generate Dependency Graph**:

  ```bash
  terraform graph | dot -Tpdf > graph.pdf
  ```

  Requires Graphviz to be installed.

- **Destroy Infrastructure**:
  To delete all created resources:
  ```bash
  terraform destroy --auto-approve
  ```

## Notes

- Ensure your AWS credentials are properly configured using the AWS CLI or environment variables.
- Adjust `security_group_rules` as needed to limit access based on your requirements.
- Modify `instance_detail` to select the desired AMI, instance type, and region.
