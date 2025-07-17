terraform {
  required_providers {
    solacebroker = {
      source = "solaceproducts/solacebroker"
    }
  }
}


resource "solacebroker_msg_vpn_client_profile" "client_profile" {
  for_each = { for idx, x in var.client_profiles : idx => x }

  msg_vpn_name                         = var.msg_vpn_name
  client_profile_name                  = each.value.client_profile_name
  allow_bridge_connections_enabled     = each.value.allow_bridge_connections_enabled
  allow_guaranteed_msg_send_enabled    = each.value.allow_guaranteed_msg_send_enabled
  allow_guaranteed_msg_receive_enabled = each.value.allow_guaranteed_msg_receive_enabled
}
