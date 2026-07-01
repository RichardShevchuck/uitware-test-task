# Azure VM — Terraform (Test Task)

Terraform IaC for provisioning a Linux virtual machine on Microsoft Azure. Provisions full networking (VNet, subnet, NSG) and a VM from an Azure Community Gallery image.

## Resources Provisioned

```
Resource Group: rg-uitware-task (polandcentral)
  │
  ├── Virtual Network        10.0.0.0/16
  │     └── Subnet           10.0.1.0/24
  │
  ├── Public IP              Static, Standard SKU
  │
  ├── Network Security Group
  │     ├── Inbound: SSH (22)
  │     ├── Inbound: HTTP (80)
  │     └── Inbound: HTTPS (443)
  │
  ├── Network Interface      + NSG association
  │
  └── Linux VM               Standard_D2s_v3, SSH key auth
        └── OS Disk          Standard_LRS
        └── Image            Community Gallery (devops-growth-v3 1.0.0)
```

## Tech Stack

- **IaC:** Terraform (`azurerm` provider ≥ 3.116.0)
- **Cloud:** Microsoft Azure
- **VM Size:** Standard_D2s_v3 (2 vCPU, 8 GB RAM)
- **Image:** Azure Community Gallery — `devopsgrowth/devops-growth-v3/1.0.0`
- **Auth:** SSH public key (no password)

## Prerequisites

- Azure CLI installed and authenticated (`az login`)
- Terraform ≥ 1.0
- SSH key pair

## Deploy

```bash
# Generate SSH key if needed
ssh-keygen -t rsa -b 4096 -f ~/.ssh/uitware_key

# Deploy
terraform init
terraform plan
terraform apply

# Get public IP and connect
terraform output public_ip
ssh <admin_username>@<public-ip> -i ~/.ssh/uitware_key
```

## Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `resource_group_name` | `rg-uitware-task` | Azure resource group |
| `location` | `polandcentral` | Azure region |
| `vm_name` | `uitware-vm` | VM name |
| `admin_username` | — | Linux admin user |
| `public_key_path` | `~/.ssh/uitware_key.pub` | SSH public key path |

## Cleanup

```bash
terraform destroy
```
