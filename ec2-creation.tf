#Key-pair
resource "aws_key_pair" "my_key" {
  key_name   = "deployer-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII42IhKK+sSLliC1JGOKXiJm5zRzXJcMjO7QofZSB70d ubuntu@ip-172-31-47-160"
}
#VPC

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

#security group

resource "aws_security_group" "my_security_group" {
  name        = "automate-sg"
  description = "Will add an tf generated security group"
  vpc_id      = aws_default_vpc.default.id  #interpolation

tags = {
    Name = "automate-sg"
  }

#inbound rule also called as ingress

ingress{
	from_port = 22
	to_port = 22
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]

}

ingress{
	from_port = 80
	to_port = 80
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
}

#outbound rules also called as egress

egress{
	from_port = 0
	to_port = 0
 	protocol = -1
	cidr_blocks = ["0.0.0.0/0"]

} 
}



#EC2 instance 


resource aws_instance my_instance{
	key_name = aws_key_pair.my_key.key_name
	security_groups = [aws_security_group.my_security_group.name]
	instance_type = "t2.micro"
	ami = "ami-004364947f82c87a0"  #ubuntu
	
root_block_device{
	volume_size = 15
	volume_type = "gp3"


}
	
tags = {
	Name = "automated-ec2"
}



}
