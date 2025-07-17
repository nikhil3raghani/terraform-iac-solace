variable "cred" {
  description = "Solace broker credentials and URL"
  type = object({
    username = string
    password = string
    url      = string
  })
}

variable "msg_vpn" {
  description = "Message VPN configuration"
  type = object({
    msg_vpn_name              = string
    enabled                   = bool
    max_msg_spool_usage       = number
    authentication_basic_type = string
  })
}

variable "client_profile" {
  description = "Client profile configurations"
  type = list(object({
    client_profile_name                  = string
    allow_bridge_connections_enabled     = bool
    allow_guaranteed_msg_send_enabled    = bool
    allow_guaranteed_msg_receive_enabled = bool
  }))
}

variable "acl_profile" {
  description = "ACL profile configurations"
  type = list(object({
    acl_profile_name               = string
    client_connect_default_action  = string
    publish_topic_default_action   = string
    subscribe_topic_default_action = string
  }))
}

variable "publish_exp" {
  description = "Publish topic exceptions"
  type = list(object({
    acl_profile_name               = string
    publish_topic_exception        = string
    publish_topic_exception_syntax = string
  }))
}

variable "subscribe_exp" {
  description = "Subscribe topic exceptions"
  type = list(object({
    acl_profile_name                 = string
    subscribe_topic_exception        = string
    subscribe_topic_exception_syntax = string
  }))
}

variable "username" {
  description = "Client usernames"
  type = list(object({
    client_username     = string
    password            = string
    client_profile_name = string
    acl_profile_name    = string
    enabled             = bool
  }))
}

variable "queue" {
  description = "Queue configurations"
  type = list(object({
    queue_name           = string
    ingress_enabled      = bool
    egress_enabled       = bool
    access_type          = string
    max_msg_spool_usage  = number
    max_bind_count       = number
    owner                = string
    permission           = string
  }))
}

variable "subscription" {
  description = "Queue subscriptions"
  type = list(object({
    queue_name         = string
    subscription_topic = string
  }))
}
