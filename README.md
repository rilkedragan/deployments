# deployments
Repository for storing all code related to devops  
## cts-app - contains Kubernetes deployment manifests for CTS application  

 cts-deploy.yaml is Kubernetes manifest defining Service and Deployment resource for the application. It has resource part defining CPU requsted by the app.
 cts-hpa is Kubernetes horizontal pod autoscaler resource for the cts-app Deployment which defines pod auto scaling on CPU utilization criteria.

## infra - contains Terraform code for building GKE cluster  

Terraform code used for building private standard GKE cluster with 2 node pools in VPC and private subnets. One node pool is defined as general with autoscaling enabled and the other is "spot" node pool for deploying fault-tolerant services. Router is defined to NAT all traffic coming out of instances.  


## Jenkinsfile - used for Jenkins CICD job  

 Jenkinsfile is using scripted defined CICD pipeline. It is parametrized and it builds Docker image, pushes to Google Container Registry, checkout deployment files form the separate repo, change the tag version   in the deployment file and pushes back code to the deployment repo.
 Source code is pulled from Github repository and job is triggered on every code push by configured Webhook on the Github project side.
 __Screenshots showing Jenkins and Github setup__
 
 ![image](https://github.com/rilkedragan/deployments/assets/126792923/53b1cddd-b6d2-4a70-b325-4b9db3832791)

![image](https://github.com/rilkedragan/deployments/assets/126792923/177db9b4-fcd6-421b-bc3b-f3100c888657)

![image](https://github.com/rilkedragan/deployments/assets/126792923/db1abfd7-e61f-4883-9f84-ee52d672202a)

![image](https://github.com/rilkedragan/deployments/assets/126792923/7351d3a4-66a0-41f6-a26b-75902cc6c94c)

__Log sample from Jenkins job:__

_Started by GitHub push by rilkedragan
Obtained Jenkinsfile from git https://github.com/rilkedragan/deployments.git
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/CTS
[Pipeline] {
[Pipeline] timestamps
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Set vars for service)
[Pipeline] stage
[Pipeline] { (Checkout package repo)
[Pipeline] cleanWs
[2023-05-28T12:40:02.675Z] [WS-CLEANUP] Deleting project workspace...
[2023-05-28T12:40:02.675Z] [WS-CLEANUP] Deferred wipeout is used...
[2023-05-28T12:40:02.680Z] [WS-CLEANUP] done
[Pipeline] git
[2023-05-28T12:40:02.720Z] The recommended git tool is: NONE
[2023-05-28T12:40:02.720Z] using credential 1c4a02db-a6d8-4f77-847a-544b75075995
[2023-05-28T12:40:02.730Z] Cloning the remote Git repository
[2023-05-28T12:40:02.730Z] Cloning repository https://github.com/rilkedragan/CTS
[2023-05-28T12:40:02.730Z]  > git init /var/lib/jenkins/workspace/CTS # timeout=10
[2023-05-28T12:40:02.741Z] Fetching upstream changes from https://github.com/rilkedragan/CTS
[2023-05-28T12:40:02.741Z]  > git --version # timeout=10
[2023-05-28T12:40:02.747Z]  > git --version # 'git version 2.25.1'
[2023-05-28T12:40:02.747Z] using GIT_ASKPASS to set credentials 
[2023-05-28T12:40:02.748Z]  > git fetch --tags --force --progress -- https://github.com/rilkedragan/CTS +refs/heads/*:refs/remotes/origin/* # timeout=10
[2023-05-28T12:40:03.079Z]  > git config remote.origin.url https://github.com/rilkedragan/CTS # timeout=10
[2023-05-28T12:40:03.084Z]  > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
[2023-05-28T12:40:03.089Z] Avoid second fetch
[2023-05-28T12:40:03.089Z]  > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
[2023-05-28T12:40:03.102Z] Checking out Revision 0e1fb9e6db1ad54d53fd8aaf1b0631e93b6b0228 (refs/remotes/origin/main)
[2023-05-28T12:40:03.102Z]  > git config core.sparsecheckout # timeout=10
[2023-05-28T12:40:03.107Z]  > git checkout -f 0e1fb9e6db1ad54d53fd8aaf1b0631e93b6b0228 # timeout=10
[2023-05-28T12:40:03.113Z]  > git branch -a -v --no-abbrev # timeout=10
[2023-05-28T12:40:03.118Z]  > git checkout -b main 0e1fb9e6db1ad54d53fd8aaf1b0631e93b6b0228 # timeout=10
[2023-05-28T12:40:03.124Z] Commit message: "Update Dockerfile"
[2023-05-28T12:40:03.124Z]  > git rev-list --no-walk 99de545d0328c1912845970adf718b5ac7394119 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Build Docker image)
[Pipeline] sh
[2023-05-28T12:40:03.509Z] + git rev-parse --short HEAD
[Pipeline] sh
[2023-05-28T12:40:03.817Z] + docker build -t us.gcr.io/radiant-land-387911/ctsapp:rc1-0e1fb9e .
[2023-05-28T12:40:09.013Z] Sending build context to Docker daemon  129.5kB

[2023-05-28T12:40:09.013Z] Step 1/5 : FROM python:3.9
[2023-05-28T12:40:09.013Z]  ---> 3a6891e6dad7
[2023-05-28T12:40:09.013Z] Step 2/5 : COPY CTS.py /app/CTS.py
[2023-05-28T12:40:09.013Z]  ---> Using cache
[2023-05-28T12:40:09.013Z]  ---> c03b1a55e25b
[2023-05-28T12:40:09.013Z] Step 3/5 : RUN pip install flask requests
[2023-05-28T12:40:09.013Z]  ---> Using cache
[2023-05-28T12:40:09.013Z]  ---> 3034cda06282
[2023-05-28T12:40:09.013Z] Step 4/5 : WORKDIR /app
[2023-05-28T12:40:09.013Z]  ---> Using cache
[2023-05-28T12:40:09.013Z]  ---> e23290a9edcf
[2023-05-28T12:40:09.013Z] Step 5/5 : CMD ["python", "CTS.py"]
[2023-05-28T12:40:09.013Z]  ---> Using cache
[2023-05-28T12:40:09.013Z]  ---> df3b19ce32be
[2023-05-28T12:40:09.013Z] Successfully built df3b19ce32be
[2023-05-28T12:40:09.013Z] Successfully tagged us.gcr.io/radiant-land-387911/ctsapp:rc1-0e1fb9e
[Pipeline] sh
[2023-05-28T12:40:09.296Z] + docker push us.gcr.io/radiant-land-387911/ctsapp:rc1-0e1fb9e
[2023-05-28T12:40:10.208Z] The push refers to repository [us.gcr.io/radiant-land-387911/ctsapp]
[2023-05-28T12:40:10.208Z] 1a70f3919567: Preparing
[2023-05-28T12:40:10.208Z] 539957dd2bbc: Preparing
[2023-05-28T12:40:10.208Z] 17146956440c: Preparing
[2023-05-28T12:40:10.208Z] d728625c9df0: Preparing
[2023-05-28T12:40:10.208Z] 0a46eb371c0b: Preparing
[2023-05-28T12:40:10.208Z] ea9a66bcf3b5: Preparing
[2023-05-28T12:40:10.208Z] d140420135e3: Preparing
[2023-05-28T12:40:10.209Z] b4b4f5c5ff9f: Preparing
[2023-05-28T12:40:10.209Z] b0df24a95c80: Preparing
[2023-05-28T12:40:10.209Z] 974e52a24adf: Preparing
[2023-05-28T12:40:10.209Z] ea9a66bcf3b5: Waiting
[2023-05-28T12:40:10.209Z] b0df24a95c80: Waiting
[2023-05-28T12:40:10.209Z] 974e52a24adf: Waiting
[2023-05-28T12:40:10.209Z] b4b4f5c5ff9f: Waiting
[2023-05-28T12:40:10.209Z] d140420135e3: Waiting
[2023-05-28T12:40:10.759Z] d728625c9df0: Layer already exists
[2023-05-28T12:40:10.759Z] 1a70f3919567: Layer already exists
[2023-05-28T12:40:10.759Z] 0a46eb371c0b: Layer already exists
[2023-05-28T12:40:10.759Z] 17146956440c: Layer already exists
[2023-05-28T12:40:10.759Z] 539957dd2bbc: Layer already exists
[2023-05-28T12:40:10.759Z] ea9a66bcf3b5: Layer already exists
[2023-05-28T12:40:10.759Z] d140420135e3: Layer already exists
[2023-05-28T12:40:11.010Z] b0df24a95c80: Layer already exists
[2023-05-28T12:40:11.010Z] 974e52a24adf: Layer already exists
[2023-05-28T12:40:11.010Z] b4b4f5c5ff9f: Layer already exists
[2023-05-28T12:40:12.871Z] rc1-0e1fb9e: digest: sha256:45c6292cbef93ee9bef2232a9c98c5085d17ec40e45ce0970bdfecc1343a1932 size: 2425
[Pipeline] sh
[2023-05-28T12:40:13.162Z] + echo Deploying to Production..
[2023-05-28T12:40:13.162Z] Deploying to Production..
[Pipeline] sh
[2023-05-28T12:40:13.454Z] + git clone git@github.com:rilkedragan/deployments
[2023-05-28T12:40:13.455Z] Cloning into 'deployments'...
[Pipeline] sh
[2023-05-28T12:40:15.079Z] + git remote set-url origin git@github.com:rilkedragan/deployments.git
[Pipeline] sh
[2023-05-28T12:40:15.366Z] + cd deployments/cts-app
[2023-05-28T12:40:15.366Z] + sed -i s/rc1-.*/rc1-0e1fb9e/ cts-deploy.yaml
[2023-05-28T12:40:15.366Z] + git add .
[2023-05-28T12:40:15.366Z] + git commit -m Deploy CTS 0e1fb9e to dev
[2023-05-28T12:40:15.366Z] [main dde6087] Deploy CTS 0e1fb9e to dev
[2023-05-28T12:40:15.366Z]  1 file changed, 1 insertion(+), 1 deletion(-)
[2023-05-28T12:40:15.366Z] + git push origin main
[2023-05-28T12:40:16.277Z] remote: Resolving deltas:   0% (0/2)        
remote: Resolving deltas:  50% (1/2)        
remote: Resolving deltas: 100% (2/2)        
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.        
[2023-05-28T12:40:16.527Z] To github.com:rilkedragan/deployments
[2023-05-28T12:40:16.527Z]    125ace1..dde6087  main -> main
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // timestamps
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS_

 On the GKE cluster there is __Argocd__ application deployed that automatically detects changes in the deployment file pushed to the deployment repository and apply change to the app.
 
![image](https://github.com/rilkedragan/deployments/assets/126792923/67e5c7db-0d85-4e44-8045-454ba2e2f711)
 
![image](https://github.com/rilkedragan/deployments/assets/126792923/f19241dc-35e2-429c-9129-5feb4545aafc)

 
