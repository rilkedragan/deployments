node{
    def gitCredentialsId = params.credentialsId
    
   
 timestamps {

    stage('Set vars for service'){

    if (params.service == "CTS") {
       gitSourcePath = "https://github.com/rilkedragan/CTS"    
       branchName = params.branchName
       service_to_build = "CTS"
    }
    stage('Checkout package repo') {
        cleanWs()
        git branch: branchName,
            credentialsId: github_cred,
            url: gitSourcePath
            }  
    }
    stage('Build Docker image'){
          GIT_COMMIT = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
          sh "docker build -t gcr.io/radiant-land-387911/ctsapp:${GIT_COMMIT} ."
          sh "docker push gcr.io/radiant-land-387911/ctsapp:${GIT_COMMIT}"
          sh "echo Deploying to Production.."
          sh "git clone https://rilkedragan:Pipica14@github.com/rilkedragan/deployments"
          sh "git config --global user.email \"dragan.rilke@gmail.com\""
          sh "git config --global user.name \"Dragan Rilke\""
          sh "sed -i \"s/rc1-.*/rc1-${GIT_COMMIT}/\" cts-deploy.yaml && git add . && git commit -m \"Deploy ${service_to_build} ${GIT_COMMIT} to dev\" && git push origin main"
      }
 }
}