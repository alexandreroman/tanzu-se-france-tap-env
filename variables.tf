variable "tanzu_net_username" {
  type        = string
  description = "Tanzu Network username"
}

variable "tanzu_net_password" {
  type        = string
  description = "Tanzu Network password"
}

variable "tap_registry_username" {
  type        = string
  description = "TAP registry username"
}

variable "tap_registry_password" {
  type        = string
  description = "TAP registry password"
}

variable "tap_registry_hostname" {
  type        = string
  description = "TAP registry hostname"
}

variable "tap_registry_repo" {
  type        = string
  default     = "tap"
  description = "TAP registry repository"
}

variable "github_access_token" {
  type        = string
  description = "GitHub access token"
}

variable "github_oidc_clientId" {
  type        = string
  description = "GitHub OIDC client id"
}

variable "github_oidc_clientSecret" {
  type        = string
  description = "GitHub OIDC client secret"
}
