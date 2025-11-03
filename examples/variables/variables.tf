variable "state_file_path" {
  description = "Path to the local state file"
  type        = string
}

variable "min_value" {
  description = "Minimum value for the random integer"
  type        = number
}

variable "max_value" {
  description = "Maximum value for the random integer"
  type        = number
}