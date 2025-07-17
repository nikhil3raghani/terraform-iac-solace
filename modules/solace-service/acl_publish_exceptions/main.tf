terraform {
  required_providers {
    solacebroker = {
      source = "solaceproducts/solacebroker"
    }
  }
}


resource "solacebroker_msg_vpn_acl_profile_publish_topic_exception" "publish_ex" {
  for_each = { for idx, val in var.publish_exceptions : idx => val }

  msg_vpn_name                    = var.msg_vpn_name
  acl_profile_name                = each.value.acl_profile_name
  publish_topic_exception         = each.value.publish_topic_exception
  publish_topic_exception_syntax = each.value.publish_topic_exception_syntax
}

