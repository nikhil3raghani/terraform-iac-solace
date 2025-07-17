terraform {
  required_providers {
    solacebroker = {
      source = "solaceproducts/solacebroker"
    }
  }
}

resource "solacebroker_msg_vpn" "vpn" {
  msg_vpn_name              = var.vpn_config.msg_vpn.msg_vpn_name
  enabled                   = var.vpn_config.msg_vpn.enabled
  max_msg_spool_usage       = var.vpn_config.msg_vpn.max_msg_spool_usage
  authentication_basic_type = var.vpn_config.msg_vpn.authentication_basic_type
}

