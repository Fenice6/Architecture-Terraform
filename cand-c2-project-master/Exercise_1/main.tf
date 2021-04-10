# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
region = "eu-central-1"
profile = "admin"
}

resource "aws_vpc" "udacity_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    type = "Virtual Private Cloud"
    creation = "Terraform",
    goal = "Udacity Exam"
  }
}

resource "aws_subnet" "udacity_subnet" {
  vpc_id            = aws_vpc.udacity_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    type = "Subnet"
    creation = "Terraform",
    goal = "Udacity Exam"
  }
}


# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "Udacity_T2" {
  count = "4"
  ami = "ami-0db9040eb3ab74509"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.udacity_subnet.id
  tags = {
    type = "Server EC2 T2"
    creation = "Terraform",
    goal = "Udacity Exam"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "Udacity_M4" {
  count = "2"
  ami = "ami-0db9040eb3ab74509"
  instance_type = "m4.large"
  subnet_id = aws_subnet.udacity_subnet.id
  tags = {
    type = "Server EC2 M4"
    creation = "Terraform",
    goal = "Udacity Exam"
  }
}