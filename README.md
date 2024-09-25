# Terraform VPC Module using for_each

This module demonstrates the use of Terraform's `for_each` meta-argument to create multiple VPCs with custom configurations. It showcases how to efficiently manage and deploy multiple VPCs with varying attributes in a single module.

## Module Structure

The module consists of three main files:

1. `variables.tf`: Defines the input variables for the module.
2. `main.tf`: Contains the main VPC resource configuration.
3. `outputs.tf`: Specifies the outputs of the module.

## Key Concepts

### 1. Variable Definition

In `variables.tf`, we define a map of objects to represent multiple VPC configurations:

```hcl
variable "vpcs" {
  type = map(object({
    cidr = string
    tenancy = string
    tags = map(string)
  }))
}
```

This allows us to pass in multiple VPC configurations as a single variable.

### 2. Resource Creation with for_each

In `main.tf`, we use the `for_each` meta-argument to create multiple VPC resources:

```hcl
resource "aws_vpc" "main" {
  for_each = var.vpcs
  cidr_block       = each.value["cidr"]
  instance_tenancy = each.value["tenancy"]
  tags = each.value["tags"]
}
```

This creates a VPC for each entry in the `vpcs` map, using the map keys as unique identifiers for each VPC.

### 3. Output Configuration

In `outputs.tf`, we output the entire VPC resource:

```hcl
output "vpcs" {
  value = aws_vpc.main
}
```

This provides access to all attributes of all created VPCs.

## Usage

To use this module, you would typically create a `main.tf` file in your root module with content similar to:

```hcl
module "vpc" {
  source = "./modules/vpc"

  vpcs = {
    vpc1 = {
      cidr = "10.100.0.0/16"
      tenancy = "default"
      tags = {
        Name = "vpc1"
      }
    },
    vpc2 = {
      cidr = "10.110.0.0/16"
      tenancy = "default"
      tags = {
        Name = "vpc2"
      }
    }
  }
}
```

This would create two VPCs with the specified configurations.

## Benefits of this Approach

1. **Flexibility**: Easily create multiple VPCs with different configurations.
2. **DRY (Don't Repeat Yourself)**: Avoid repeating resource blocks for each VPC.
3. **Maintainability**: Centralize VPC configurations in a single map.
4. **Scalability**: Add or remove VPCs by simply modifying the input map.

## Conclusion

This module demonstrates an efficient way to manage multiple VPC deployments using Terraform's `for_each` meta-argument. It provides a flexible and scalable approach to VPC creation, allowing for easy management of multiple VPCs with varying configurations.

## Additional Resources

- [Terraform for_each documentation](https://www.terraform.io/language/meta-arguments/for_each)
- [AWS VPC Resource documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)