##########################################
##---CONFIGURE SOURCE OF THE PROVIDER---##
##########################################
terraform {
  required_providers {
    solacebroker = {
      source = "registry.terraform.io/solaceproducts/solacebroker"
    }
  }
}

##################################
##----CONFIGURE THE PROVIDER----##
##################################

provider "solacebroker" {
  username = var.cred.username
  password = var.cred.password
  url      = var.cred.url
}

module "vpn" {
  source   = "../../modules/solace-service/vpn"
  providers = {
    solacebroker = solacebroker
  }
  msg_vpn_name              = var.msg_vpn.msg_vpn_name
  enabled                   = var.msg_vpn.enabled
  max_msg_spool_usage       = var.msg_vpn.max_msg_spool_usage
  authentication_basic_type = var.msg_vpn.authentication_basic_type
}


module "client_profile" {
  source   = "../../modules/solace-service/client_profile"
  providers = {
    solacebroker = solacebroker
  }
  msg_vpn_name    = module.vpn.msg_vpn_name
  client_profiles = var.client_profile
}


# OUTPUTS #

output "message_vpn_name" {
  value = module.vpn.msg_vpn_name
}

output "client_profiles_all" {
  value = module.client_profile.client_profile_names_list
}
