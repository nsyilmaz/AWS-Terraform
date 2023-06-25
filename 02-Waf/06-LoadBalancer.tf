
resource "aws_lb_target_group" "LBTargetGroup" {
    deregistration_delay          = 300
    load_balancing_algorithm_type = "round_robin"
    name                          = "LBTargetGroup"
    port                          = 80
    protocol                      = "HTTP"
    protocol_version              = "HTTP1"
    slow_start                    = 0
    target_type                   = "instance"
    vpc_id                        = aws_vpc.test_vpc.id

    health_check {
        enabled             = true
        healthy_threshold   = 5
        interval            = 30
        matcher             = "200"
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 5
        unhealthy_threshold = 2
    }

    stickiness {
        cookie_duration = 86400
        enabled         = false
        type            = "lb_cookie"
    }
}


resource "aws_lb_target_group_attachment" "TargetGroupAttach-1" {
    target_group_arn = aws_lb_target_group.LBTargetGroup.arn
    target_id        = aws_instance.WebServer-1.id
    port             = 80
}

resource "aws_lb_target_group_attachment" "TargetGroupAttach-2" {
    target_group_arn = aws_lb_target_group.LBTargetGroup.arn
    target_id        = aws_instance.WebServer-2.id
    port             = 80
}



resource "aws_lb" "MyLoader" {
    drop_invalid_header_fields = false
    enable_deletion_protection = false
    enable_http2               = true
    idle_timeout               = 60
    internal                   = false
    ip_address_type            = "ipv4"
    load_balancer_type         = "application"
    name                       = "MyLoader"
    security_groups            = [
        aws_security_group.Allow-SSH-HTTP.id,
    ]
    subnets                    = [
        aws_subnet.subnet-pub-1.id,
        aws_subnet.subnet-pub-2.id,
    ]
    tags                       = {}
    tags_all                   = {}

}



resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.MyLoader.id
  port = 80

  default_action {
    target_group_arn = aws_lb_target_group.LBTargetGroup.arn
    type             = "forward"
  }
}





