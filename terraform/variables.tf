variable "ecs_cluster" {
  description = "ECS cluster name"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR Block"
}

variable "public_subnet_1_cidr" {
  description = "Public Subnet 1 CIDR"
}

variable "public_subnet_2_cidr" {
  description = "Public Subnet 2 CIDR"
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

variable "nginx_service_name" {
  description = "Name of nginx service"
}

variable "nginx_container_name" {
  description = "Name of nginx container"
}

variable "nginx_family" {
  description = "Family name of nginx application"
}

variable "flask_service_name" {
  description = "Name of flask service"
}

variable "flask_container_name" {
  description = "Name of flask container"
}

variable "flask_family" {
  description = "Family name of flask application"
}

variable "iam_role_instance_name" {
  description = "Role Name of Instance"
}

variable "iam_instance_profile_name" {
  description = "Name of instance profile"
}

variable "iam_role_service_name" {
  description = "Role Name of Service"
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
