# assignments
### [ansible-playbook]
---
Ansible is a configuration management tool used to setup required configuration on cluster.
This assignment playbook will setup MySQL database and NodeJS application using ansible.

### [cloud-formation]
---
Cloud Formation is used to setup infrastructure as a code in AWS environment.
Cloud Formation Stack scripts are used to setup an infrastructure with a VPC with 1 public subnet and 1 private subnet. It will setup a RDS MySQL database and python application in private subnet and web application in public subnet with load balancing/autoscaling feature.

### [docker-compose]
---
Docker compose is used to create docker containers. This assignment will deploy sample python application and redis in docker containers using dockerfile and docker compose command.

### [kubernetes]
---
This assignment deploys sample application in AWS environment using kubernetes. One Master and two Worker nodes were created in a cluster. Then Service was exposed for a deployment.

### [jenkins]
---
This assignment deploys sample application in all private instances using declarative pipeline. Same task was also performed using shared pipeline.

### [terraform]
---
This assignment deploys python application in ECS (without fargate).  In this assignment, terraform script setup vpc, iam roles, Loadbalancers, target groups, task definitions and services.
