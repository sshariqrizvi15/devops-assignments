resource "null_resource" "ecs_service_role_depends_on" {
  triggers = {
    # This reference creates an implicit dependency on the variable, and thus
    # transitively on everything the variable itself depends on.
    deps = "${jsonencode(var.service_depends_on)}"
  }
}

data "aws_ecs_task_definition" "flask" {
  task_definition = "${aws_ecs_task_definition.flask.family}"
}

data "template_file" "flask_task_definition" {
  template = "${file("${"${path.module}/templates/flask-task-definition.json"}")}"
}

resource "aws_ecs_task_definition" "flask" {
    family                = "${var.flask_family}"
    container_definitions = "${data.template_file.flask_task_definition.rendered}"
}

data "aws_ecs_task_definition" "nginx" {
  task_definition = "${aws_ecs_task_definition.nginx.family}"
}

data "template_file" "nginx_task_definition" {
  template = "${file("${"${path.module}/templates/nginx-task-definition.json"}")}"
}

resource "aws_ecs_task_definition" "nginx" {
    family                = "${var.nginx_family}"
    container_definitions = "${data.template_file.nginx_task_definition.rendered}"
}

resource "aws_ecs_service" "test-flask-service" {
  	name            = "${var.flask_service_name}"
  	iam_role        = "${var.ecs-service-role}"
  	cluster         = "${var.ecs_cluster}"
  	task_definition = "${aws_ecs_task_definition.flask.family}:${max("${aws_ecs_task_definition.flask.revision}", "${data.aws_ecs_task_definition.flask.revision}")}"
  	desired_count   = 1

  	load_balancer {
    	target_group_arn  = "${var.flask-target-group}"
    	container_port    = 5000
    	container_name    = "${var.flask_container_name}"
	}
	depends_on = [ "null_resource.ecs_service_role_depends_on"]
}

resource "aws_ecs_service" "test-nginx-service" {
  	name            = "${var.nginx_service_name}"
  	iam_role        = "${var.ecs-service-role}"
  	cluster         = "${var.ecs_cluster}"
  	task_definition = "${aws_ecs_task_definition.nginx.family}:${max("${aws_ecs_task_definition.nginx.revision}", "${data.aws_ecs_task_definition.nginx.revision}")}"
  	desired_count   = 1

  	load_balancer {
    	target_group_arn  = "${var.ecs-target-group}"
    	container_port    = 80
    	container_name    = "${var.nginx_container_name}"
	}
	depends_on = [ "null_resource.ecs_service_role_depends_on"]
}