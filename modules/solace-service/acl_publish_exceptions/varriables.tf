variable "msg_vpn_name" {
  type = string
}

variable "publish_exceptions" {
  type = list(object({
    acl_profile_name                = string
    publish_topic_exception         = string
    publish_topic_exception_syntax = string
  }))
  default = []
}

