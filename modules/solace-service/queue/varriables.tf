variable "msg_vpn_name" {
  type = string
}

variable "queues" {
  type = list(object({
    queue_name          = string
    ingress_enabled     = bool
    egress_enabled      = bool
    max_msg_spool_usage = number
  }))
}
