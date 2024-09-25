# Terraform toset VPC Module

This module demonstrates the use of Terraform's `toset` function to create unique VPCs with custom names. It showcases how to handle potential duplicate CIDR blocks while maintaining the correlation between CIDRs and their intended names.

## Key Concept: Name Assignment

The core of this module's functionality lies in the following line of code:

```hcl
Name = var.vpc_names[index(var.vpc_cidrs, each.value)]
```

This line assigns a name to each VPC based on the corresponding index of its CIDR block in the original list.

### Breakdown of the Name Assignment

1. **`each.value`**:
    - In the context of `for_each = toset(var.vpc_cidrs)`, this represents the current CIDR block being processed in the loop.

2. **`index(var.vpc_cidrs, each.value)`**:
    - The `index()` function finds the position of a given element in a list.
    - `var.vpc_cidrs` is the original list of CIDR blocks.
    - `each.value` is the current CIDR block.
    - This function returns the index (position) of the current CIDR block in the original list.

3. **`var.vpc_names[...]`**:
    - `var.vpc_names` is the list of VPC names provided.
    - The `[...]` syntax is used to access an element in the list by its index.

### How It Works

- For each unique CIDR block (ensured by `toset`), we find its original position in the `vpc_cidrs` list.
- We then use that position to select the corresponding name from the `vpc_names` list.
- This approach ensures that even if `toset` removes duplicate CIDRs, we still assign the correct name to each VPC based on its original position in the input list.

## Example

Consider the following input:

```hcl
vpc_cidrs = ["10.0.0.0/16", "10.1.0.0/16", "10.0.0.0/16", "10.2.0.0/16"]
vpc_names = ["VPC1", "VPC2", "VPC3", "VPC4"]
```

After `toset` processes `vpc_cidrs`, we effectively have:

```hcl
unique_cidrs = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"]
```

The resulting name assignments will be:

1. "10.0.0.0/16" : `index()` returns 0, so it gets the name "VPC1"
2. "10.1.0.0/16" : `index()` returns 1, so it gets the name "VPC2"
3. "10.2.0.0/16" : `index()` returns 3, so it gets the name "VPC4"

## Conclusion

This method allows us to maintain the correlation between CIDRs and names even when duplicates are removed, ensuring that each unique VPC gets its intended name. It's an efficient way to handle potential duplicates while still providing custom naming capabilities in Terraform VPC configurations.