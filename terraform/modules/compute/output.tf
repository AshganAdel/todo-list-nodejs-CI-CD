output "control_public_ip" {
  value = aws_instance.ec2_control.public_ip
}

output "agent_public_ip" {
  value = aws_instance.ec2_agent.public_ip
}