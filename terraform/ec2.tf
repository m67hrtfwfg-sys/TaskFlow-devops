resource "aws_instance" "web" {
  ami                    = "ami-001d1a2ebd1aaa718"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = "taskflow-key"

  tags = {
    Name = "taskflow-web-server"
  }
  user_data = <<EOF
  #!/bin/bash
  apt update -y
  apt install -y docker.io
  systemctl enable docker
  systemctl start docker
  docker run -d -p 80:80 nginx
  EOF
}

