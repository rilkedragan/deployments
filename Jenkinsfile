node{
    def gitCredentialsId = params.credentialsId
    def IMAGE_REPO_NAME = params.service
   
 timestamps {

    stage('Set vars for service'){

    if (params.service == "CTS") {
       gitSourcePath = "https://github.com/rilkedragan/CTS"    
       branchName = params.branchName
       service_to_build = "CTS"
    }
    }
    stage('Build Docker image'){
          GIT_COMMIT = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
          sh " docker build -t gcr.io/radiant-land-387911/ctsapp:${GIT_COMMIT} .} ."
          sh "docker push gcr.io/radiant-land-387911/ctsapp:${GIT_COMMIT}"
          sh "echo Deploying to Production.."
          sh "git clone https://rilkedragan:Pipica14@ghttps://github.com/rilkedragan/deployments"
          sh "git config --global user.email \"dragan.rilke@gmail.com\""
          sh "git config --global user.name \"Dragan Rilke\""
          sh "sed -i \"s/rc1-.*/rc1-${IMAGE_TAG}/\" cts-deploy.yaml && git add . && git commit -m \"Deploy ${service_to_build} ${IMAGE_TAG} to dev\" && git push origin main"
      }
 }
}