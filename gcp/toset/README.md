# Terraform GCP VPC Module using toset

This module demonstrates the use of Terraform's `toset` function to create multiple VPC networks in Google Cloud Platform (GCP) with custom configurations. It showcases how to efficiently manage and deploy multiple VPC networks with varying attributes in a single module.

## Module Structure

The module consists of the following files:

1. `modules/gcp-vpc/variables.tf`: Defines the input variables for the VPC module.
2. `modules/gcp-vpc/main.tf`: Contains the main VPC network and subnetwork resource configurations.
3. `modules/gcp-vpc/outputs.tf`: Specifies the outputs of the VPC module.
4. `main.tf` (root): Calls the VPC module and sets up the provider.
5. `versions.tf`: Specifies the required Terraform and provider versions.

## Key Concepts

### 1. Variable Definition

In `modules/gcp-vpc/variables.tf`, we define the following variables:

```hcl
variable "project_id" {
  type        = string
  description = "The ID of the project where this VPC will be created"
}

variable "region" {
  type        = string
  description = "The region where resources will be created"
  default     = "us-central1"
}

variable "vpcs" {
  type = list(object({
    name                            = string
    cidr                            = string
    auto_create_subnetworks         = bool
    routing_mode                    = string
    description                     = string
    delete_default_routes_on_create = bool
    mtu                             = number
  }))
  description = "List of VPC configurations"
}
```

### 2. Resource Creation with toset

In `modules/gcp-vpc/main.tf`, we use the `toset` function along with `for_each` to create multiple VPC network resources:

```hcl
resource "google_compute_network" "vpc_network" {
  for_each = toset([for vpc in var.vpcs : vpc.name])
  
  project                         = var.project_id
  name                            = each.key
  auto_create_subnetworks         = var.vpcs[index(var.vpcs.*.name, each.key)].auto_create_subnetworks
  routing_mode                    = var.vpcs[index(var.vpcs.*.name, each.key)].routing_mode
  description                     = var.vpcs[index(var.vpcs.*.name, each.key)].description
  delete_default_routes_on_create = var.vpcs[index(var.vpcs.*.name, each.key)].delete_default_routes_on_create
  mtu                             = var.vpcs[index(var.vpcs.*.name, each.key)].mtu

  # ... (additional configuration)
}
```

### 3. Routing Modes: REGIONAL vs GLOBAL

(Content about routing modes remains the same as in the previous version)

### 4. Module Usage

The root `main.tf` file demonstrates how to use the VPC module:

```hcl
module "vpc" {
  source = "./modules/gcp-vpc"

  project_id = var.project_id
  region     = var.region  # You can override the default region here

  vpcs = [
    {
      name                            = "vpc-network-1"
      cidr                            = "10.0.0.0/16"
      auto_create_subnetworks         = false
      routing_mode                    = "GLOBAL"
      description                     = "VPC Network 1"
      delete_default_routes_on_create = false
      mtu                             = 1460
    },
    {
      name                            = "vpc-network-2"
      cidr                            = "10.1.0.0/16"
      auto_create_subnetworks         = false
      routing_mode                    = "REGIONAL"
      description                     = "VPC Network 2"
      delete_default_routes_on_create = true
      mtu                             = 1500
    },
    # Add more VPC configurations as needed
  ]
}
```

## Usage

To use this module:

1. Ensure you have the correct Terraform version installed (0.13.0 or later).
2. Set up your GCP credentials.
3. Modify the root `main.tf` file to include your desired VPC configurations.
4. Create a `terraform.tfvars` file or use command-line flags to set values for `project_id` and `region` (if you want to override the default).
5. Run `terraform init` to initialize the module.
6. Run `terraform plan` to see the planned changes.
7. Run `terraform apply` to create the VPC networks.

Example `terraform.tfvars`:
```hcl
project_id = "your-gcp-project-id"
region     = "us-west1"  # This will override the default region
```

## Benefits of this Approach

(Content about benefits remains the same as in the previous version)

## Conclusion

This module demonstrates an efficient way to manage multiple VPC network deployments in GCP using Terraform's `toset` function. It provides a flexible and scalable approach to VPC network creation, allowing for easy management of multiple VPC networks with varying configurations and routing modes across different regions.

## Additional Resources

(Content about additional resources remains the same as in the previous version)