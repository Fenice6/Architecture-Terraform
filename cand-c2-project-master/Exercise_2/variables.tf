# TODO: Define the variable for aws_region
variable "aws_region" {
  description = "(Required) AWS region to deploy."
  type        = string

  validation {
    condition     = length(var.aws_region) > 3 && substr(var.aws_region, 0, 3) == "eu-"
    error_message = "The aws_region value must start with \"eu-\"."
  }
}
