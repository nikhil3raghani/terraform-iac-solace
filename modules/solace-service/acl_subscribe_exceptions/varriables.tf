variable "msg_vpn_name" {
  type = string
}

variable "subscribe_exceptions" {
  type = list(object({
    acl_profile_name                = string
    subscribe_topic_exception         = string
    subscribe_topic_exception_syntax = string
  }))
}
