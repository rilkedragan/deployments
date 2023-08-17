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
          sh "docker build -t us.gcr.io/radiant-land-387911/ctsapp:rc1-${GIT_COMMIT} ."
          sh "docker push us.gcr.io/radiant-land-387911/ctsapp:rc1-${GIT_COMMIT}"
          sh "echo Deploying to Production.."
          sh "git clone git@github.com:rilkedragan/deployments"
          sh "git remote set-url origin git@github.com:rilkedragan/deployments.git"
          sh "cd  deployments/cts-app && sed -i \"s/rc1-.*/rc1-${GIT_COMMIT}/\" cts-deploy.yaml && git add . && git commit -m \"Deploy ${service_to_build} ${GIT_COMMIT} to dev\" && git push origin main"
      }
 }
}