variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnets" {
  description = "Map of subnets"
  type = map(object({
    cidr   = string
    public = bool
    name   = string
  }))
}
