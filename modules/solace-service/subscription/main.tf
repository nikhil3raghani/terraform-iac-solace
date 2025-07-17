terraform {
  required_providers {
    solacebroker = {
      source = "solaceproducts/solacebroker"
    }
  }
}

resource "solacebroker_msg_vpn_queue_subscription" "subs" {
  for_each = {
    for idx, s in var.subscriptions :
    "${s.queue_name}:: idx " => s
  }

  msg_vpn_name       = var.msg_vpn_name
  queue_name         = each.value.queue_name
  subscription_topic = each.value.subscription_topic
}
