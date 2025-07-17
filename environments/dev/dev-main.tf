terraform {
  required_providers {
    solacebroker = {
      source  = "solaceproducts/solacebroker"
      version = ">= 1.0.0"
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


# ACL Profile per VPN
module "acl_profiles" {
  source = "../../modules/solace-service/acl_profile"

  for_each = {
    for vpn_key, vpn_cfg in var.vpn_configs : vpn_key => vpn_cfg
    if length(try(vpn_cfg.acl_profiles, [])) > 0
  }

  msg_vpn_name = module.vpn[each.key].msg_vpn_name
  acl_profiles = each.value.acl_profiles

  providers = {
    solacebroker = solacebroker
  }

  depends_on = [module.vpn]
}

# publish exceptions
module "acl_publish_exceptions" {
  source = "../../modules/solace-service/acl_publish_exceptions"

  for_each = {
    for vpn_key, vpn_cfg in var.vpn_configs :
    vpn_key => vpn_cfg
    if length(try(vpn_cfg.acl_publish_exceptions, [])) > 0
  }

  msg_vpn_name        = module.vpn[each.key].msg_vpn_name
  publish_exceptions  = each.value.acl_publish_exceptions

  providers = {
    solacebroker = solacebroker
  }

  depends_on = [module.acl_profiles]
}


# subscribe exceptions
module "acl_subscribe_exceptions" {
  source = "../../modules/solace-service/acl_subscribe_exceptions"

  for_each = {
    for vpn_key, vpn_cfg in var.vpn_configs :
    vpn_key => vpn_cfg
    if length(try(vpn_cfg.acl_subscribe_exceptions, [])) > 0
  }

  msg_vpn_name        = module.vpn[each.key].msg_vpn_name
  subscribe_exceptions  = each.value.acl_subscribe_exceptions

  providers = {
    solacebroker = solacebroker
  }

  depends_on = [module.acl_profiles]
}


#new sub try


# Client usernames
module "usernames" {
  source = "../../modules/solace-service/username"

  for_each = {
    for vpn_key, vpn_cfg in var.vpn_configs :
    vpn_key => vpn_cfg
    if length(try(vpn_cfg.usernames, [])) > 0
  }

  msg_vpn_name = module.vpn[each.key].msg_vpn_name
  usernames    = each.value.usernames

  providers = {
    solacebroker = solacebroker
  }

  depends_on = [module.vpn,module.client_profile,module.acl_profiles]
}

# Queues per VPN
module "queues" {
  source = "../../modules/solace-service/queue"

  for_each = {
    for vpn_key, vpn_cfg in var.vpn_configs :
    vpn_key => vpn_cfg
    if length(try(vpn_cfg.queues, [])) > 0
  }

  msg_vpn_name = module.vpn[each.key].msg_vpn_name
  queues       = each.value.queues

  providers = {
    solacebroker = solacebroker
  }

  depends_on = [module.vpn, module.usernames]
}


# Subscription for queues
module "subscriptions" {
  source = "../../modules/solace-service/subscription"

  for_each = {
    for vpn_key, vpn_cfg in var.vpn_configs :
    vpn_key => vpn_cfg
    if length(try(vpn_cfg.subscriptions, [])) > 0
  }

  msg_vpn_name  = module.vpn[each.key].msg_vpn_name
  subscriptions = each.value.subscriptions

  providers = {
    solacebroker = solacebroker
  }

  depends_on = [module.queues]
}


/*
# Outputs
output "vpn_names" {
  value = { for k, v in module.vpn : k => v.msg_vpn_name }
}

output "client_profiles_all" {
  value = { for k, v in module.client_profile : k => v.client_profile_names_list }
}
*/