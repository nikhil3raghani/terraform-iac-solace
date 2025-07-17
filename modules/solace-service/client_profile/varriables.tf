variable "msg_vpn_name" {}
variable "client_profiles" {
  type = list(object({
    client_profile_name                   = string
    allow_bridge_connections_enabled      = bool
    allow_guaranteed_msg_send_enabled     = bool
    allow_guaranteed_msg_receive_enabled  = bool
  }))
}
