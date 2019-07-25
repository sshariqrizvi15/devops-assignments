# terraform

This assignment deploys python application in ECS (without fargate). In this assignment, terraform script setup vpc, iam roles, Loadbalancers, target groups, task definitions and services.
I used modular and workspaces in this project.

Modules:
- alb-asg: Load Balancer and Target Groups
- ecs: ECS Cluster
- iam-roles: Instance and Service Role
- services-and-definitions: task definitions and services
- vpc: VPC along subnets, route tables and security group
