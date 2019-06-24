# cloud-formation

**AWS Architecture**

There is a VPC having public and private subnets. Web server is in public subnet and Application Server and RDS are in private subnet.
Auto scaling and load balancing features are added for Web and Application Servers. External (Web) facing ELB has two public instances in it 
with proper health checks and scaling policies. Another ELB is Internal Facing
has two public instances with proper health checks and scaling policies. Traffic to Web servers is routed through the Web ELB
and Traffic to Application Servers from WebServers should is routed through 
Application ELB.Application Servers and RDS are not directly accessible from the Internet.


**Nested Stack File Architecture**
- parent.yaml run other yaml scripts
- vpc.yaml has vpc, subnets, nat gateway, internet gateway and route table information
- security-groups.yaml has security information
- rds.yaml has RDS database information
- loadbalancers.yaml has loadbalancer, autoscaling group and launch configurations.
