pipeline {
    agent any
    
    environment {
        github_URL = "https://github.com/cssp007/ORMAE"
    }
    
    
    
    stages {       
        
        stage('Getting Code from SCM') {
            steps {
                script {
                  try {
                  git "${github_URL}"
                  }catch(err) {
                   mail bcc: '', body: 'Github url is not accessible or wrong url. Error type: ${err}. Please check and fix it.', cc: '', from: '', replyTo: '', subject: 'Error while accessing Github url', to: 'pandey.somnath007@gmail.com'
                  }
                }
            }
         }
        
   
        
        stage('Creating nginx docker images') {
            steps {
                script {
                  try {
                    sh "docker build -t cssp007143/custom-nginx:${build_number} ."
                  }catch(err) {
                   mail bcc: '', body: 'Unable to create nginx image. Error type: ${err}. Please check and fix it.', cc: '', from: '', replyTo: '', subject: 'Error while creating nginx image', to: 'pandey.somnath007@gmail.com'
                  }
   
                }
            }
        }
	    
	
	stage('Push nginx image to Docker Hub') {
            steps {
                script {
                   try {
                    withCredentials([string(credentialsId: 'DOCKER_HUB_PASS', variable: 'DOCKER_HUB_PASS')]) {
                    sh "docker login -u cssp007143 -p $DOCKER_HUB_PASS"
                }
	            sh "docker push cssp007143/custom-nginx:${build_number}"
                 }catch(err) {
                mail bcc: '', body: 'Unable to push docker image to Docker Hub. Error type: ${err}. Please check and fix it.', cc: '', from: '', replyTo: '', subject: 'Error while pushing nginx image to Docker hub', to: 'pandey.somnath007@gmail.com'
                  }
                }
            }
        }
        
        
        stage('Deploy tomcat in K8s Cluster') {
            steps {
                script {
                   kubernetesDeploy(
				      configs: 'nginx.yaml',
				      kubeconfigId: 'KUBERNETES_CONFIG'
				   ) 
                }
            }
	}

       
       stage('Deploy mysql in K8s Cluster') {
            steps {
                script {
                   kubernetesDeploy(
                                      configs: 'mysql.yaml',
                                      kubeconfigId: 'KUBERNETES_CONFIG'
                                   )
                }
            }
        }

}
}
