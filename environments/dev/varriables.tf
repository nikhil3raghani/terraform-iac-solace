variable "cred" {
  default = {
    username = "admin"
    password = "admin"
    url      = "http://localhost:8080"
  }
}

variable "msg-vpn" {
  default = {
    msg_vpn_name              = "TEST"
    enabled                   = true
    max_msg_spool_usage       = 1000
    authentication_basic_type = "none"
  }
}

variable "client-profile" {
  default = [{
    "client_profile_name"                   = "default",
    "allow_bridge_connections_enabled"      = true,
    "allow_guaranteed_msg_send_enabled"     = true,
    "allow_guaranteed_msg_receive_enabled"  = true
  }]
}

variable "acl-profile" {
  default = [{
    "acl_profile_name"                : "default",
    "client_connect_default_action"   : "allow",
    "publish_topic_default_action"    : "disallow",
    "subscribe_topic_default_action"  : "disallow"
  }]
}

variable "publish-exp" {
  default = [{
    "acl_profile_name"               : "default",
    "publish_topic_exception"        : "test/>",
    "publish_topic_exception_syntax" : "smf"
  }]
}

variable "subscribe-exp" {
  default = [{
    "acl_profile_name"                 : "default",
    "subscribe_topic_exception"        : "test/>",
    "subscribe_topic_exception_syntax" : "smf"
  }]
}

variable "username" {
  default = [{
    "client_username"      : "default",
    "password"             : "default",
    "client_profile_name"  : "default",
    "acl_profile_name"     : "default",
    "enabled"              : "true"
  }]
}

variable "queue" {
  default = [{
    "queue_name" : "q1",
    "ingress_enabled" : true,
    "egress_enabled" : true,
    "access_type" : "exclusive",
    "max_msg_spool_usage" : 10,
    "max_bind_count" : 2,
    "owner" : "default",
    "permission" : "consume"
  }]
}

variable "subscription" {
  default = [{
    "queue_name"         : "q1",
    "subscription_topic" : "test/1"
  }]
}