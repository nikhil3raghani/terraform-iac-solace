terraform {
  required_providers {
    solacebroker = {
      source = "solaceproducts/solacebroker"
    }
  }
}


resource "solacebroker_msg_vpn_acl_profile" "acl_profile" {
  for_each = { for idx, acl in var.acl_profiles : idx => acl }

  msg_vpn_name                   = var.msg_vpn_name
  acl_profile_name               = each.value.acl_profile_name


  
  client_connect_default_action = each.value.client_connect_default_action
  publish_topic_default_action  = each.value.publish_topic_default_action
  subscribe_topic_default_action = each.value.subscribe_topic_default_action
}