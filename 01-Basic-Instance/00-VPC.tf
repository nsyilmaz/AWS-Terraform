provider "aws" {
    profile = "default"
    region  = "us-east-1"
}



terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.27"
        }
    }

    required_version = ">= 0.14.9"
}



resource "aws_vpc" "test_vpc" {
    assign_generated_ipv6_cidr_block = false
    cidr_block                       = "172.30.0.0/16"
    enable_classiclink               = false
    enable_classiclink_dns_support   = false
    enable_dns_hostnames             = false
    enable_dns_support               = true
    instance_tenancy                 = "default"
    tags                             = {
        "Name" = "Secrove-VPC"
    }
}
