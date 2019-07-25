provider "aws" {
    region = "us-east-2"
}


terraform {
    backend "s3" {
        bucket = "shariqterraform"
        key = "state.tfstate"
        region = "us-east-2"
    }
}

module "vpc" {
  source = "modules/vpc"
  vpc_cidr = "${var.vpc_cidr}"
  public_subnet_1_cidr = "${var.public_subnet_1_cidr}"
  public_subnet_2_cidr = "${var.public_subnet_2_cidr}"
}

module "iam_roles" {
  source = "modules/iam-roles"
  iam_role_instance_name = "${var.iam_role_instance_name}"
  iam_instance_profile_name = "${var.iam_instance_profile_name}"
  iam_role_service_name = "${var.iam_role_service_name}"
}

module "ecs" {
  source = "modules/ecs"
  ecs_cluster = "${var.ecs_cluster}"
}

module "alb_asg" {
  source = "modules/alb-asg"
  ecs_cluster = "${module.ecs.test-ecs-cluster}"
  test_vpc = "${module.vpc.test_vpc}"
  test_public_sn_01 = "${module.vpc.test_public_sn_01}"
  test_public_sn_02 = "${module.vpc.test_public_sn_02}"
  test_public_sg = "${module.vpc.test_public_sg}"
  ecs-instance-profile = "${module.iam_roles.ecs-instance-profile}"
  ecs_key_pair_name = "${var.ecs_key_pair_name}"
  max_instance_size = "${var.max_instance_size}"
  min_instance_size = "${var.min_instance_size}"
  desired_capacity = "${var.desired_capacity}"
  ecs_load_balancer_name = "${var.ecs_load_balancer_name}"
  nginx_target_group_name = "${var.nginx_target_group_name}"
  flask_target_group_name = "${var.flask_target_group_name}"
  ecs-launch-configuration_name = "${var.ecs-launch-configuration_name}"
  ecs_autoscaling_group_name = "${var.ecs_autoscaling_group_name}"
}
module "services_and_definitions" {
  source = "modules/services-and-definitions"
  ecs-service-role = "${module.iam_roles.ecs-service-role}"
  ecs_cluster = "${module.ecs.test-ecs-cluster}"
  ecs-target-group = "${module.alb_asg.ecs-target-group}"
  flask-target-group = "${module.alb_asg.flask-target-group}"
  nginx_service_name = "${var.nginx_service_name}"
  nginx_container_name = "${var.nginx_container_name}"
  nginx_family = "${var.nginx_family}"
  flask_service_name = "${var.flask_service_name}"
  flask_container_name = "${var.flask_container_name}"
  flask_family = "${var.flask_family}"
}