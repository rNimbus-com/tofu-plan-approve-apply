# OpenTofu Variables Example

This example demonstrates how to use variables in OpenTofu to configure a random integer resource and local backend state file.

## Files

- `variables.tf` - Defines the input variables
- `terraform.tfvars` - Sets values for the min and max variables
- `main.tf` - Contains the main configuration with resources and outputs

## Variables

- `state_file_name` (string) - Name of the local state file (must be provided when running)
- `min_value` (number) - Minimum value for the random integer (default: 1)
- `max_value` (number) - Maximum value for the random integer (default: 100)

## Usage

1. Initialize OpenTofu (provide the state file name):
   ```bash
   tofu init -var="state_file_name=terraform.tfstate"
   ```

2. Plan the configuration:
   ```bash
   tofu plan -var="state_file_name=terraform.tfstate"
   ```

3. Apply the configuration:
   ```bash
   tofu apply -var="state_file_name=terraform.tfstate"
   ```

## Output

The configuration will output a random integer between the min and max values defined in the variables.