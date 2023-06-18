resource "aws_instance" "VPN" {
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


    tags = {
        Name = "VPN"
    }
}


resource "aws_instance" "POC" {
    ami                         = "ami-09e67e426f25ce0d7"
    instance_type               = "t2.micro"
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.subnet-pub-2.id
    key_name                    = "AWS"
    private_ip                  = "172.30.2.5"
    source_dest_check           = false

    vpc_security_group_ids      = [
        aws_security_group.Allow-SSH-HTTP.id,
    ]


    tags = {
        Name = "POC"
    }
}


resource "aws_instance" "InternalFileServer" {
    ami                         = "ami-09e67e426f25ce0d7"
    instance_type               = "t2.micro"
    associate_public_ip_address = false
    subnet_id                   = aws_subnet.subnet-priv-1.id
    key_name                    = "AWS"
    private_ip                  = "172.30.10.5"
    source_dest_check           = false

    vpc_security_group_ids      = [
        aws_security_group.Allow-SSH-HTTP.id,
    ]


    tags = {
        Name = "InternalFileServer"
    }
}


resource "aws_instance" "WebServer-1" {
    ami                         = "ami-09e67e426f25ce0d7"
    instance_type               = "t2.micro"
    associate_public_ip_address = false
    subnet_id                   = aws_subnet.subnet-priv-1.id
    key_name                    = "AWS"
    private_ip                  = "172.30.10.10"

    vpc_security_group_ids      = [
        aws_security_group.Allow-SSH-HTTP.id,
    ]


    user_data = "${file("InstallApache.sh")}"


    tags = {
        Name = "WebServer-1"
    }

    depends_on = [
        aws_route_table_association.private-1
    ]
}


resource "aws_instance" "WebServer-2" {
    ami                         = "ami-09e67e426f25ce0d7"
    instance_type               = "t2.micro"
    associate_public_ip_address = false
    subnet_id                   = aws_subnet.subnet-priv-2.id
    key_name                    = "AWS"
    private_ip                  = "172.30.20.10"

    vpc_security_group_ids      = [
        aws_security_group.Allow-SSH-HTTP.id,
    ]


    user_data = "${file("InstallApache.sh")}"


    tags = {
        Name = "WebServer-2"
    }

    depends_on = [
        aws_route_table_association.private-2
    ]
}
