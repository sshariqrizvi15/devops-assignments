output "ecs-target-group" {
  value = "${aws_alb_target_group.ecs-target-group.arn}"
}

output "flask-target-group" {
  value = "${aws_alb_target_group.flask-target-group.arn}"
}
