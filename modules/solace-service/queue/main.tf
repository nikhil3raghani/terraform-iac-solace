terraform {
  required_providers {
    solacebroker = {
      source = "solaceproducts/solacebroker"
    }
  }
}

resource "solacebroker_msg_vpn_queue" "queues" {
  for_each = {
    for q in var.queues :
    q.queue_name => q
  }

  msg_vpn_name        = var.msg_vpn_name
  queue_name          = each.value.queue_name
  ingress_enabled     = each.value.ingress_enabled
  egress_enabled      = each.value.egress_enabled
  max_msg_spool_usage = each.value.max_msg_spool_usage
}
