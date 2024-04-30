variable "lambda_function_name" {
  default = "example"
}

variable "lambda_handler" {
  default = "handler"
}

variable "lambda_runtime" {
  default = "nodejs12.x"
}

variable "zip_filename" {
    type = string
    description = "Filename of the code to be executed by the Lambda function"
}

variable "environment_variables" {
  type = map(string)
  default = {}  
}