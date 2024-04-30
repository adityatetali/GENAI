variable "create" {
  type        = bool
  default     = true
  description = "Controls if API Gateway resources should be created"
}

variable "create_api_gateway" {
  type        = bool
  default     = true
  description = "Whether to create API Gateway"
}

variable "create_defualt_stage" {
  type        = bool
  default     = true
  description = "Whether to create default stage"
}

variable "create_default_stage_api_mapping" {
  type        = bool
  default     = true
  description = "Whether to create default stage API mapping"
}

# variable "create_stage" {
#   type        = bool
#   default     = false
#   description = "Whether to create custom stage"
# }

# variable "create_stage_api_mapping" {
#   type        = bool
#   default     = false
#   description = "Whether to create stage API mapping"
# }

variable "create_api_domain_name" {
  type        = bool
  default     = true
  description = "Whether to create API domain name resource"
}

variable "create_routes_and_integrations" {
  type        = bool
  default     = true
  description = "Whether to create routes and integrations resources"
}

variable "create_vpc_link" {
  type        = bool
  default     = true
  description = "Whether to create VPC links"
}

# API Gateway
variable "name" {
  type        = string
  default     = ""
  description = "The name of the API"
}

variable "Description" {
  type        = string
  default     = null
  description = "The description of the API"
}

variable "default_route_settings" {
  type        = map(string)
  default     = {}
  description = "Settings for default route"
}

variable "disable_execute_api_endpoint" {
  description = "Whether clients can invoke the API by using the default execute-api endpoint. To require that clients use a custom domain name to invoke the API, disable the default endpoint" 
  type = string
  default     = false
}
variable "fail_on warnings" {
  description = "Whether warnings should return an error while API Gateway is creating or
  updating the resource using an OpenAPI specification. Defaults to false. Applicable for HTTP APIs."
  type = bool
  default = false 
}
variable "protocol_type" {
  description = "The API protocol. Valid values: HTTP, WEBSOCKET"
  type        = string
  default     = "HTTP"
}
variable "api_key_selection_expression" {
  description = "An API key selection expression. Valid values: $context.authorizer usageIdentifierKey, Srequest.header.x-api-key." 
  type        = string
  default     = "frequest.header x-api-key"
}
variable "route_key" {
  description = "Part of quick create. Specifies any route key. Applicable for HTTP APIs."
  type        = string
default       = null
}
variable "route_selection_expression" {
  description = "The route selection expression for the API."
  type        = string
  default     = "Grequest.method frequest.path"
}
variable "cors_configuration" {
  description = "The cross-origin resource sharing (CORS) configuration. Applicable for HTTP APIs."
  type        = any
  default     = {} 
