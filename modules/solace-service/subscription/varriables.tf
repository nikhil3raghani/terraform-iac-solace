variable "msg_vpn_name" {
  type = string
}

variable "subscriptions" {
  type = list(object({
    queue_name         = string
    subscription_topic = string
  }))
}
