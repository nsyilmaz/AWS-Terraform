

#####-Public Subnets-#####

resource "aws_subnet" "subnet-pub-1" {
    availability_zone               = "us-east-1c"
    cidr_block                      = "172.30.1.0/24"
    tags                            = {
        "Name" = "Subnet-Pub-1-172.30.1.0"
    }
    vpc_id                          = aws_vpc.test_vpc.id
}


resource "aws_subnet" "subnet-pub-2" {
    availability_zone               = "us-east-1d"
    cidr_block                      = "172.30.2.0/24"
    tags                            = {
        "Name" = "Subnet-Pub-2-172.30.2.0"
    }
    vpc_id                          = aws_vpc.test_vpc.id
}






#####-Private Subnets-#####

resource "aws_subnet" "subnet-priv-1" {
    availability_zone               = "us-east-1c"
    cidr_block                      = "172.30.10.0/24"
    tags                            = {
        "Name" = "Subnet-Priv-2-172.30.10.0"
    }
    vpc_id                          = aws_vpc.test_vpc.id
}

resource "aws_subnet" "subnet-priv-2" {
    availability_zone               = "us-east-1d"
    cidr_block                      = "172.30.20.0/24"
    tags                            = {
        "Name" = "Subnet-Priv-2-172.30.20.0"
    }
    vpc_id                          = aws_vpc.test_vpc.id
}

