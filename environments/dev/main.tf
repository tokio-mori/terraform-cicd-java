provider "aws" {
    region = "us-west-2"
}

resource "aws_instance" "dev_server_test" {
  # EC2 -> AMIカタログ参照
  ami = "ami-0be5f59fbc80d980c"
  instance_type = "t2.micro"

  tags = {
    name = "DevServer"
    environments = "Development"
  }
}