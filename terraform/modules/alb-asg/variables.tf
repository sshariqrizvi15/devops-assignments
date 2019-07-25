variable "ecs_cluster" {
      description = "ecs cluster"
}

variable "test_vpc" {
  description = "VPC name for Test environment"
}

variable "test_public_sn_01" {
  description = "Public Subnet 1"
}

variable "test_public_sn_02" {
  description = "Public Subnet 2"
}

variable "test_public_sg" {
  description = "Public Security Group"
}

variable "ecs-instance-profile" {
  description = "ECS Instance Profile"
}

variable "ecs_key_pair_name" {
  description = "EC2 instance key pair name"
}

variable "max_instance_size" {
  description = "Maximum number of instances in the cluster"
}

variable "min_instance_size" {
  description = "Minimum number of instances in the cluster"
}

variable "desired_capacity" {
  description = "Desired number of instances in the cluster"
}

variable "ecs_load_balancer_name" {
  description = "Name of ECS Load Balancer"
}

variable "nginx_target_group_name" {
  description = "Name of nginx target group"
}

variable "flask_target_group_name" {
  description = "Name of flask target group"
}

variable "ecs-launch-configuration_name" {
  description = "Name of Launch Configuration"
}

variable "ecs_autoscaling_group_name" {
  description = "Name of ECS Autoscaling group"
}