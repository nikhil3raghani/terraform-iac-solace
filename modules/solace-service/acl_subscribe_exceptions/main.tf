terraform {
  required_providers {
    solacebroker = {
      source = "solaceproducts/solacebroker"
    }
  }
}


resource "solacebroker_msg_vpn_acl_profile_subscribe_topic_exception" "subscribe_ex" {
  for_each = { for idx, x in var.subscribe_exceptions : idx => x }

  msg_vpn_name                    = var.msg_vpn_name
  acl_profile_name                = each.value.acl_profile_name
  subscribe_topic_exception         = each.value.subscribe_topic_exception
  subscribe_topic_exception_syntax = each.value.subscribe_topic_exception_syntax
}
