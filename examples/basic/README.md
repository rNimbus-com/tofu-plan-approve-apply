# Simple Random Number Terraform Example

This example demonstrates how to use Terraform to generate a random number and output it.

## Files

- `main.tf` - The main Terraform configuration file

## What it does

1. Uses the `random` provider from HashiCorp
2. Creates a random integer between 1 and 100
3. Outputs the generated random number

## How to use

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Apply the configuration:
   ```bash
   terraform apply
   ```

3. The random number will be displayed in the output under `random_number`

## Example Output

```
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

random_number = 42