output "acl_profile_names_list" {
  value = [for cp in solacebroker_msg_vpn_acl_profile.acl_profile : cp.acl_profile_name]
}
