variable "msg_vpn_name" {
  description = "Name of the VPN"
  type        = string
}

variable "acl_profiles" {
  description = "List of ACL profiles to create"
  type = list(object({
    acl_profile_name               = string
    client_connect_default_action  = string
    publish_topic_default_action   = string
    subscribe_topic_default_action = string
  }))
}
