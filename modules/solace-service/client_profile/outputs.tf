output "client_profile_names_list" {
  value = [for cp in solacebroker_msg_vpn_client_profile.client_profile : cp.client_profile_name]
}
