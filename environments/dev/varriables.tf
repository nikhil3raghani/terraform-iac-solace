variable "cred" {
  description = "Solace broker credentials and URL"
  type = object({
    username = string
    password = string
    url      = string
  })
}

variable "vpn_configs" {
  description = "Configurations for multiple message VPNs"
  type = map(object({
    msg_vpn = object({
      msg_vpn_name              = string
      enabled                   = bool
      max_msg_spool_usage       = number
      authentication_basic_type = string
    })
    client_profiles = list(object({
      client_profile_name                  = string
      allow_bridge_connections_enabled     = bool
      allow_guaranteed_msg_send_enabled    = bool
      allow_guaranteed_msg_receive_enabled = bool
    }))
    acl_profiles = list(object({
      acl_profile_name               = string
      client_connect_default_action  = string
      publish_topic_default_action   = string
      subscribe_topic_default_action = string
    }))
    acl_publish_exceptions = list(object({
      acl_profile_name               = string
      publish_topic_exception        = string
      publish_topic_exception_syntax = string
    }))
    acl_subscribe_exceptions = list(object({
      acl_profile_name                 = string
      subscribe_topic_exception        = string
      subscribe_topic_exception_syntax = string
    }))
    usernames = list(object({
      client_username     = string
      password            = string
      client_profile_name = string
      acl_profile_name    = string
      enabled             = bool
    }))
    queues = list(object({
      queue_name           = string
      ingress_enabled      = bool
      egress_enabled       = bool
      access_type          = string
      max_msg_spool_usage  = number
      max_bind_count       = number
      owner                = string
      permission           = string
    }))
    subscriptions = list(object({
      queue_name         = string
      subscription_topic = string
    }))
  }))
}
