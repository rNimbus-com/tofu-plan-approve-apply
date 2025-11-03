terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

resource "random_integer" "example" {
  min = 1
  max = 100
}

output "random_number" {
  description = "A random number between 1 and 100"
  value       = random_integer.example.result
}