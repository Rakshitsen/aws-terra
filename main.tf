resource "aws_key_pair" "my_key" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
}

resource "aws_security_group" "SG-Jenkins" {
  description = "Allow ssh and jenkins port"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]  # Restrict to agent IPs if possible
 }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-Jenkins"
  }
}

resource "aws_security_group" "SG-K8s-Slave" {
  description = "Allow ssh and NodePort"

    ingress{
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress{
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
  tags = {
    Name = "SG-K8s-Slave"
  }
}

resource "aws_security_group" "SG-K8s-Master" {
  description = "Allow ssh and NodePort"

   ingress{
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress{
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }

  tags = {
    Name = "My-Security-Group"
  }
}

resource "aws_instance" "K8s_master" {
  ami           = var.K8s_ami_id
  instance_type = var.K8s_instance_type
  key_name      = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.SG-K8s-Master.name]
  user_data     = file("setupUser.sh")

  tags = {
    Name = "K8s_master"
  }
}

resource "aws_instance" "K8s_slave" {
  count         = 2
  ami           = var.K8s_ami_id
  instance_type = var.K8s_instance_type
  key_name      = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.SG-K8s-Slave.name]
  user_data     = file("setupUser.sh")

  tags = {
    Name = "K8s_slave-${count.index + 1}"
  }
}

resource "aws_instance" "Jenkins_master" {
  ami           = var.Jenkins_ami_id
  instance_type = var.Jenkins_instance_type
  key_name      = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.SG-Jenkins.name]
  user_data     = file("setupUser.sh")

  tags = {
    Name = "Jenkins_master"
  }
}
