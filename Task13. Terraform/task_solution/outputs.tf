output "bastion_host_ip" {
  value = module.ec2_creator.instances_info.bastion_host.ip_public
}