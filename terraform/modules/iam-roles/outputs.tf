output "ecs-instance-profile" {
  value = "${aws_iam_instance_profile.ecs-instance-profile.id}"
}

output "ecs-service-role" {
  value = "${aws_iam_role.ecs-service-role.name}"
}