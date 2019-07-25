ecs_cluster = "Shariq-Cluster-New"
vpc_cidr = "10.0.0.0/16"
public_subnet_1_cidr = "10.0.0.0/24"
public_subnet_2_cidr = "10.0.1.0/24"
ecs_key_pair_name = "ShariqKeyPair"
max_instance_size = "2"
min_instance_size = "1"
desired_capacity = "1"
nginx_service_name = "test-nginx-service"
nginx_container_name = "shariq-nginx"
nginx_family = "nginx-task"
flask_service_name = "test-flask-service"
flask_container_name = "shariq-flask"
flask_family = "flask-task"
iam_role_instance_name = "ecs-instance-role"
iam_instance_profile_name = "ecs-instance-profile"
iam_role_service_name = "ecs-service-role"
ecs_load_balancer_name = "ecs-load-balancer"
nginx_target_group_name = "ecs-target-group"
flask_target_group_name = "flask-target-group"
ecs-launch-configuration_name = "ecs-launch-configuration"
ecs_autoscaling_group_name = "ecs-autoscaling-group"