variable "ami" {
  description = "The AMI ID for EC2 instances"
  type        = string
}

variable "instances" {
  description = "Map of instances"
  type = map(object({
    subnet_id = string
    name      = string
  }))
}
