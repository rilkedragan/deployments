# deployments
Repository for storing all code related to devops  
## cts-app - contains Kubernetes deployment manifests for CTS application  

 cts-deploy.yaml is Kubernetes manifest defining Service and Deployment resource for the application. It has resource part defining CPU requsted by the app.
 cts-hpa is Kubernetes horizontal pod autoscaler resource for the cts-app Deployment which defines pod auto scaling on CPU utilization criteria.

## infra - contains Terraform code for building GKE cluster  

Terraform code used for building private standard GKE cluster with 2 node pools in VPC and private subnets. One node pool is defined as general with autoscaling enabled and the other is "spot" node pool for deploying fault-tolerant services. Router is defined to NAT all traffic coming out of instances. This solution automatically scales number of nodes and combined with HPA resource for the Kubernetes deployment it should handle all scaling.
Terraform state is kept locally for this exercize, for production use it should be set to use remote bucket for backend. Also, for some more generative solution variables should be used.

![image](https://github.com/rilkedragan/deployments/assets/126792923/12f7b1dd-0e1d-47a2-bf19-cfcf01e4a1ba)

![image](https://github.com/rilkedragan/deployments/assets/126792923/7306e2c7-0929-44d5-80cc-c1af91374e98)


## Jenkinsfile - used for Jenkins CICD job  

 Jenkinsfile is using scripted defined CICD pipeline. It is parametrized and it builds Docker image, pushes to Google Container Registry, checkout deployment files form the separate repo, change the tag version   in the deployment file and pushes back code to the deployment repo.
 Source code is pulled from Github repository and job is triggered on every code push by configured Webhook on the Github project side.
 __Screenshots showing Jenkins and Github setup__
 
 ![image](https://github.com/rilkedragan/deployments/assets/126792923/53b1cddd-b6d2-4a70-b325-4b9db3832791)

![image](https://github.com/rilkedragan/deployments/assets/126792923/177db9b4-fcd6-421b-bc3b-f3100c888657)

![image](https://github.com/rilkedragan/deployments/assets/126792923/db1abfd7-e61f-4883-9f84-ee52d672202a)

![image](https://github.com/rilkedragan/deployments/assets/126792923/7351d3a4-66a0-41f6-a26b-75902cc6c94c)

__Log sample from Jenkins job:__

[Jenkins-log-sample.txt](https://github.com/rilkedragan/deployments/files/11584658/Jenkins-log-sample.txt)

 On the GKE cluster there is __Argocd__ application deployed that automatically detects changes in the deployment file pushed to the deployment repository and apply change to the app.
 
![image](https://github.com/rilkedragan/deployments/assets/126792923/67e5c7db-0d85-4e44-8045-454ba2e2f711)
 
![image](https://github.com/rilkedragan/deployments/assets/126792923/f19241dc-35e2-429c-9129-5feb4545aafc)

 
