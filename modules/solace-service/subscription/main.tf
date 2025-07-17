terraform {
  required_providers {
    solacebroker = {
      source = "solaceproducts/solacebroker"
    }
  }
}

resource "solacebroker_msg_vpn_queue_subscription" "subs" {
  for_each = {
    for pair in flatten([
      for sub in var.subscriptions : [
        for topic in sub.topics : {
          key         = "${sub.queue_name}::${topic}"
          queue_name  = sub.queue_name
          topic       = topic
        }
      ]
    ]) : pair.key => {
      queue_name = pair.queue_name
      topic      = pair.topic
    }
  }

  msg_vpn_name       = var.msg_vpn_name
  queue_name         = each.value.queue_name
  subscription_topic = each.value.topic
}



