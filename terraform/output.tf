output "control_plane_ip" {
  value = module.compute.control_public_ip
}

output "agent_ip" {
  value = module.compute.agent_public_ip
}