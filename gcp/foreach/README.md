# Terraform GCP VPC Module using for_each

This module demonstrates the use of Terraform's `for_each` meta-argument to create multiple VPC networks in Google Cloud Platform (GCP) with custom configurations. It showcases how to efficiently manage and deploy multiple VPC networks with varying attributes in a single module.

## Module Structure

The module consists of the following files:

1. `modules/gcp-vpc/variables.tf`: Defines the input variables for the VPC module.
2. `modules/gcp-vpc/main.tf`: Contains the main VPC network resource configuration.
3. `modules/gcp-vpc/outputs.tf`: Specifies the outputs of the VPC module.
4. `variables.tf` (root): Defines variables for the root module, including `project_id` and `region`.
5. `main.tf` (root): Calls the VPC module and sets up the provider.
6. `versions.tf`: Specifies the required Terraform and provider versions.

## Key Concepts

### 1. Variable Definition

In the root `variables.tf`, we define the following variables:

```hcl
variable "project_id" {
  type        = string
  description = "The ID of the project where these VPCs will be created"
}

variable "region" {
  type        = string
  description = "The region where resources will be created"
}
```

In `modules/gcp-vpc/variables.tf`, we define a map of objects to represent multiple VPC configurations.

### 2. Resource Creation with for_each

In `modules/gcp-vpc/main.tf`, we use the `for_each` meta-argument to create multiple VPC network resources.

### 3. Routing Modes: REGIONAL vs GLOBAL

When creating a VPC network in GCP, you can choose between two routing modes:

1. **REGIONAL routing mode**:
    - Routes apply to resources within the same region only.
    - Each region's subnet resources are isolated from other regions.
    - Provides better network isolation between regions.
    - Suitable for scenarios where you want to keep traffic within a specific region or have region-specific routing policies.

2. **GLOBAL routing mode**:
    - Routes apply to resources across all regions.
    - Allows for more flexible architectures spanning multiple regions.
    - Simplifies network management for multi-region deployments.
    - Suitable for scenarios where you want seamless communication between resources in different regions.

Choose the routing mode based on your specific use case and network architecture requirements.

### 4. Module Usage

The root `main.tf` file demonstrates how to use the VPC module:

```hcl
provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source = "./modules/gcp-vpc"

  project_id = var.project_id

  vpcs = {
    vpc1 = {
      name                            = "vpc-network-1"
      auto_create_subnetworks         = false
      routing_mode                    = "GLOBAL"
      description                     = "VPC Network 1"
      delete_default_routes_on_create = false
      mtu                             = 1460
      tags                            = ["vpc1", "production"]
    },
    vpc2 = {
      name                            = "vpc-network-2"
      auto_create_subnetworks         = true
      routing_mode                    = "REGIONAL"
      description                     = "VPC Network 2"
      delete_default_routes_on_create = true
      mtu                             = 1500
      tags                            = ["vpc2", "development"]
    }
  }
}
```

Note how we specify different routing modes for each VPC in this example.

### 5. Version Control

The `versions.tf` file specifies the required Terraform and provider versions.

## Usage

To use this module:

1. Ensure you have the correct Terraform version installed (0.13.0 or later).
2. Set up your GCP credentials.
3. Modify the root `main.tf` file to include your desired VPC configurations, including the appropriate routing mode for each VPC.
4. Create a `terraform.tfvars` file or use command-line flags to set values for `project_id` and `region`.
5. Run `terraform init` to initialize the module.
6. Run `terraform plan` to see the planned changes.
7. Run `terraform apply` to create the VPC networks.

Example `terraform.tfvars`:
```hcl
project_id = "your-gcp-project-id"
region     = "us-central1"
```

## Benefits of this Approach

1. **Flexibility**: Easily create multiple VPC networks with different configurations and routing modes.
2. **DRY (Don't Repeat Yourself)**: Avoid repeating resource blocks for each VPC network.
3. **Maintainability**: Centralize VPC configurations in a single map.
4. **Scalability**: Add or remove VPC networks by simply modifying the input map.
5. **Version Control**: Ensure compatibility with specific Terraform and provider versions.
6. **Regional Control**: Specify the region for resource creation at the root level.
7. **Routing Mode Options**: Choose between REGIONAL and GLOBAL routing modes for each VPC based on your specific requirements.

## Conclusion

This module demonstrates an efficient way to manage multiple VPC network deployments in GCP using Terraform's `for_each` meta-argument. It provides a flexible and scalable approach to VPC network creation, allowing for easy management of multiple VPC networks with varying configurations, routing modes, and across different regions.

## Additional Resources

- [Terraform for_each documentation](https://www.terraform.io/language/meta-arguments/for_each)
- [Google Compute Network Resource documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network)
- [Terraform Version Constraints](https://www.terraform.io/language/expressions/version-constraints)
- [GCP Regions and Zones](https://cloud.google.com/compute/docs/regions-zones)
- [GCP VPC Network Routing](https://cloud.google.com/vpc/docs/routes)