terraform {
  required_providers {
    solacebroker = {
      source = "solaceproducts/solacebroker"
    }
  }
}


resource "solacebroker_msg_vpn" "msg_vpn" {
  msg_vpn_name              = var.msg_vpn_name
  enabled                   = var.enabled
  max_msg_spool_usage       = var.max_msg_spool_usage
  authentication_basic_type = var.authentication_basic_type
}