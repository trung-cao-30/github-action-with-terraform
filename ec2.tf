resource "aws_instance" "ec2" {
  ami           = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  key_name      = "ec2-key"
  # iam_instance_profile = 
  subnet_id              = "subnet-0870dc3ac621b22e0"
  vpc_security_group_ids = [aws_security_group.ec2.id]
}