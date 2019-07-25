variable "ecs-service-role" {
      description = "ecs service role"
}

variable "ecs_cluster" {
      description = "ecs cluster"
}

variable "ecs-target-group" {
      description = "ecs target group"
}

variable "flask-target-group" {
      description = "flask target group"
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

variable "service_depends_on" {
  type    = "list"
  default = ["var.ecs-target-group","ecs-service-role", "var.flask-target-group"]
}