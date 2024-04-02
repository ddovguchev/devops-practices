resource "aws_key_pair" "bastion" {
  key_name   = "bastion-keypair"
  public_key = file("./ssh_keys/bastion-host_rsa.pub")
}

resource "aws_key_pair" "private_es2" {
  key_name   = "private-es2-keypair"
  public_key = file("./ssh_keys/private-instance_rsa.pub")
}