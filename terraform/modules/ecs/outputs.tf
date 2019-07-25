output "test-ecs-cluster" {
  value = "${aws_ecs_cluster.test-ecs-cluster.id}"
}