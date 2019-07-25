resource "aws_alb" "ecs-load-balancer" {
    name                = "${var.ecs_load_balancer_name}"
    security_groups     = ["${var.test_public_sg}"]
    subnets             = ["${var.test_public_sn_01}", "${var.test_public_sn_02}"]

    tags {
      Name = "ecs-load-balancer"
    }
}

resource "aws_alb_target_group" "ecs-target-group" {
    name                = "${var.nginx_target_group_name}"
    port                = "80"
    protocol            = "HTTP"
    vpc_id              = "${var.test_vpc}"

    health_check {
        healthy_threshold   = "5"
        unhealthy_threshold = "2"
        interval            = "30"
        matcher             = "200"
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = "5"
    }
    
    depends_on = ["aws_alb.ecs-load-balancer"]
    
    tags {
      Name = "ecs-target-group"
    }
}

resource "aws_alb_target_group" "flask-target-group" {
    name                = "${var.flask_target_group_name}"
    port                = "5000"
    protocol            = "HTTP"
    vpc_id              = "${var.test_vpc}"

    health_check {
        healthy_threshold   = "5"
        unhealthy_threshold = "2"
        interval            = "30"
        matcher             = "200"
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = "5"
    }
    
    depends_on = ["aws_alb.ecs-load-balancer"]

    tags {
      Name = "flask-target-group"
    }
}

resource "aws_alb_listener" "alb-listener" {
    load_balancer_arn = "${aws_alb.ecs-load-balancer.arn}"
    port              = "80"
    protocol          = "HTTP"

    default_action {
        target_group_arn = "${aws_alb_target_group.ecs-target-group.arn}"
        type             = "forward"
    }
}

resource "aws_alb_listener" "alb-flask-listener" {
    load_balancer_arn = "${aws_alb.ecs-load-balancer.arn}"
    port              = "5000"
    protocol          = "HTTP"

    default_action {
        target_group_arn = "${aws_alb_target_group.flask-target-group.arn}"
        type             = "forward"
    }
}

resource "aws_autoscaling_group" "ecs-autoscaling-group" {
    name                        = "${var.ecs_autoscaling_group_name}"
    max_size                    = "${var.max_instance_size}"
    min_size                    = "${var.min_instance_size}"
    desired_capacity            = "${var.desired_capacity}"
    vpc_zone_identifier         = ["${var.test_public_sn_01}", "${var.test_public_sn_02}"]
    launch_configuration        = "${aws_launch_configuration.ecs-launch-configuration.name}"
    health_check_type           = "ELB"
}

resource "aws_launch_configuration" "ecs-launch-configuration" {
    name                        = "${var.ecs-launch-configuration_name}"
    image_id                    = "ami-0eba5aab4550a443a"
    instance_type               = "t2.micro"
    iam_instance_profile        = "${var.ecs-instance-profile}"

    lifecycle {
      create_before_destroy = true
    }

    security_groups             = ["${var.test_public_sg}"]
    associate_public_ip_address = "true"
    key_name                    = "${var.ecs_key_pair_name}"
    user_data                   = <<EOF
                                  #!/bin/bash
                                  echo ECS_CLUSTER=${var.ecs_cluster} >> /etc/ecs/ecs.config
                                  EOF
}