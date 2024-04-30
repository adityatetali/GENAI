variable "s3_bucket_name" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "tags" {
  type = map(string)
  description = "Environment defined in tags"
}