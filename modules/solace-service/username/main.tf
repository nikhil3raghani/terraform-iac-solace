terraform {
  required_providers {
    solacebroker = {
      source = "solaceproducts/solacebroker"
    }
  }
}

resource "solacebroker_msg_vpn_client_username" "vpn_users" {
  for_each = { for idx, user in var.usernames : idx => user }

  msg_vpn_name        = var.msg_vpn_name
  client_username     = each.value.client_username
  password            = each.value.password
  client_profile_name = each.value.client_profile_name
  acl_profile_name    = each.value.acl_profile_name
  enabled             = each.value.enabled
}
