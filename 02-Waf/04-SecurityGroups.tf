resource "aws_security_group" "Allow-SSH-HTTP" {
    description = "Allow-SSH-HTTP"
    name        = "Allow-SSH-HTTP"
    vpc_id      = aws_vpc.test_vpc.id

    ingress {
            description      = "SSH"
            from_port        = 22 
            to_port          = 22
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
    }
    ingress {
            description      = "HTTP"
            from_port        = 80
            to_port          = 80
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
    }
    egress {
            description      = "ANY"
            from_port        = 0
            to_port          = 0
            protocol         = "-1"
            cidr_blocks      = ["0.0.0.0/0"]
    }

}
