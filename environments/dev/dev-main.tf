####################################################
##-------TERRAFORM SETUP FOR SOLCACE TESTING------##
####################################################

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

