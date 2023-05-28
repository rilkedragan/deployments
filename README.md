# deployments
Repository for storing all code related to devops  
## cts-app - contains Kubernetes deployment manifests for CTS application  

 cts-deploy.yaml is Kubernetes manifest defining Service and Deployment resource for the application. It has resource part defining CPU requsted by the app.
 cts-hpa is Kubernetes horizontal pod autoscaler resource for the cts-app Deployment which defines pod auto scaling on CPU utilization criteria.

## infra - contains Terraform code for building GKE cluster  

Terraform code used for building private cluster with 2 node pools in VPC and private subnets. One node pool is defined as maingeneral with autoscaling enabled and the other is "spot" node pool for deploying fault-tolerant services. Router is defined to NAT all traffic coming out of instances.  


## Jenkinsfile - used for Jenkins CICD job  

 Jenkinsfile is using scripted defined CICD pipeline. It is parametrized and it builds Docker image, pushes to Google Container Registry, checkout deployment files form the separate repo, change the tag version in the deployment file and pushes back code to the deployment repo.
 Source code is pulled from Github repository and job is triggered on every code push by configured Webhook on the Github project side.
  