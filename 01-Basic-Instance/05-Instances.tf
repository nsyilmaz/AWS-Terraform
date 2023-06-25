resource "aws_instance" "PUB-SRV-1" {
    ami                         = "ami-09e67e426f25ce0d7"
    instance_type               = "t2.micro"
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.subnet-pub-1.id
    key_name                    = "AWS"
    private_ip                  = "172.30.1.5"
    source_dest_check           = false

    vpc_security_group_ids      = [
        aws_security_group.Allow-SSH-HTTP.id,
    ]


    user_data = "${file("InstallApache.sh")}"


    tags = {
        Name = "PUB-SRV-1"
    }


    depends_on = [
        aws_route_table_association.public-1
    ]

}


resource "aws_instance" "PUB-SRV-2" {
    ami                         = "ami-09e67e426f25ce0d7"
    instance_type               = "t2.micro"
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.subnet-pub-1.id
    key_name                    = "AWS"
    private_ip                  = "172.30.1.10"
    source_dest_check           = false

    vpc_security_group_ids      = [
        aws_security_group.Allow-SSH-HTTP.id,
    ]


    user_data = "${file("InstallApache.sh")}"


    tags = {
        Name = "PUB-SRV-2"
    }


    depends_on = [
        aws_route_table_association.public-1
    ]

}




resource "aws_instance" "PRIV-SRV-1" {
    ami                         = "ami-09e67e426f25ce0d7"
    instance_type               = "t2.micro"
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.subnet-priv-1.id
    key_name                    = "AWS"
    private_ip                  = "172.30.10.5"
    source_dest_check           = false

    vpc_security_group_ids      = [
        aws_security_group.Allow-SSH-HTTP.id,
    ]


    user_data = "${file("InstallApache.sh")}"


    tags = {
        Name = "PRIV-SRV-1"
    }


    depends_on = [
        aws_route_table_association.private-1
    ]

}
