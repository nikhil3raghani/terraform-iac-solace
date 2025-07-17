variable "msg_vpn_name" {
  type = string
}

variable "usernames" {
  type = list(object({
    client_username     = string
    password            = string
    client_profile_name = string
    acl_profile_name    = string
    enabled             = bool
  }))
}
