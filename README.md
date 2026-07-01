# uitware-test-task

Terraform IaC for the Uitware test task. Provisions a Linux VM on Microsoft Azure from a pre-built community gallery image.

## Stack

| Tool | Purpose |
|------|---------|
| Terraform | Infrastructure as Code |
| Azure (azurerm >= 3.116.0) | Cloud provider |
| Azure Linux VM (Standard_D2s_v3) | Virtual machine |
| Community Gallery Image | devops-growth-v3 (pre-configured DevOps environment) |

## Resources Provisioned

```
Resource Group          rg-uitware-task  (polandcentral)
  └── Virtual Network   10.0.0.0/16
        └── Subnet      10.0.1.0/24
  └── Public IP         Static, Standard SKU
  └── NSG               Allows SSH (22), HTTP (80), HTTPS (443) inbound
  └── Network Interface + NSG association
  └── Linux VM          Standard_D2s_v3, SSH key auth, Standard_LRS OS disk
```

**Image source:** Azure Community Gallery
`devopsgrowth / devops-growth-v3 / 1.0.0`

## Quick Start

**Prerequisites:** Azure CLI authenticated, Terraform

```bash
# Generate SSH key (if not already done)
ssh-keygen -t rsa -b 4096 -f ~/.ssh/uitware_task_key

# Deploy
terraform init
terraform plan
terraform apply

# Connect
terraform output   # get public IP
ssh uitware_user@<public-ip> -i ~/.ssh/uitware_task_key
```

## Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `resource_group_name` | `rg-uitware-task` | Azure resource group name |
| `location` | `polandcentral` | Azure region |
| `vm_name` | `uitware-vm` | VM name (used as prefix for all resources) |
| `admin_username` | `uitware_user` | Linux admin user |
| `public_key_path` | `~/.ssh/uitware_task_key.pub` | Path to SSH public key |

## File Structure

```
main.tf        # All Azure resources
variables.tf   # Input variables
outputs.tf     # Public IP output
```
