terraform {
  required_providers {
    solacebroker = {
      source = "registry.terraform.io/solaceproducts/solacebroker"
    }
  }
}

provider "solacebroker" {
  username = var.cred.username
  password = var.cred.password
  url      = var.cred.url
}

# VPN Creation
module "vpn" {
  source   = "../../modules/solace-service/vpn"
  for_each = var.vpn_configs

  vpn_config = each.value
}


# Client Profile per VPN
module "client_profile" {
  for_each = {
    for vpn_key, vpn_config in var.vpn_configs :
    vpn_key => {
      vpn_key  = vpn_key
      profiles = vpn_config.client_profiles
    }
  }

  source = "../../modules/solace-service/client_profile"
  providers = {
    solacebroker = solacebroker
  }

  msg_vpn_name    = module.vpn[each.value.vpn_key].msg_vpn_name
  client_profiles = each.value.profiles

  depends_on = [module.vpn]
}

/*
# ACL Profile per VPN
module "acl_profile" {
  for_each = var.acl_profiles

  source   = "../../modules/solace-service/acl_profile"
  providers = {
    solacebroker = solacebroker
  }

  msg_vpn_name = module.vpn[each.value.vpn_key].msg_vpn_name
  acl_profiles = each.value.profiles
}

# ACL Publish Exceptions
module "publish_exceptions" {
  for_each = var.publish_exceptions

  source   = "../../modules/solace-service/acl_publish_exceptions"
  providers = {
    solacebroker = solacebroker
  }

  msg_vpn_name       = module.vpn[each.value.vpn_key].msg_vpn_name
  publish_exceptions = each.value.exceptions
}

# ACL Subscribe Exceptions
module "subscribe_exceptions" {
  for_each = var.subscribe_exceptions

  source   = "../../modules/solace-service/acl_subscribe_exceptions"
  providers = {
    solacebroker = solacebroker
  }

  msg_vpn_name         = module.vpn[each.value.vpn_key].msg_vpn_name
  subscribe_exceptions = each.value.exceptions
}

# Client usernames
module "client_usernames" {
  for_each = var.usernames

  source   = "../../modules/solace-service/client_username"
  providers = {
    solacebroker = solacebroker
  }

  msg_vpn_name = module.vpn[each.value.vpn_key].msg_vpn_name
  usernames    = each.value.entries
}

# Queues
module "queues" {
  for_each = var.queues

  source   = "../../modules/solace-service/queue"
  providers = {
    solacebroker = solacebroker
  }

  msg_vpn_name = module.vpn[each.value.vpn_key].msg_vpn_name
  queues       = each.value.entries
}

# Subscriptions
module "subscriptions" {
  for_each = var.subscriptions

  source   = "../../modules/solace-service/queue_subscription"
  providers = {
    solacebroker = solacebroker
  }

  msg_vpn_name   = module.vpn[each.value.vpn_key].msg_vpn_name
  subscriptions  = each.value.entries
}

# Outputs
output "vpn_names" {
  value = { for k, v in module.vpn : k => v.msg_vpn_name }
}

output "client_profiles_all" {
  value = { for k, v in module.client_profile : k => v.client_profile_names_list }
}
*/