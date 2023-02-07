pipeline{
  agent any
  options{
    buildDiscarder(logRotator(numToKeepStr:"2"))
  }
  stages{
    stage("SCM"){
      steps{
          git branch: 'main', url: 'https://github.com/chaan2835/icici-jfrog-artifactory.git'
      }
    }
    stage("Maven-Build"){
      steps{
          sh "mvn clean package"
      }
    }
    stage("jfrog"){
      steps{
        withCredentials([usernamePassword(credentialsId: 'jfrog-creds', passwordVariable: 'Chandra@2835', usernameVariable: 'jenkins')]) {
             echo "jfrog stage"
             sh "chmod +x ci/"
             sh "chmod +x ci/push.sh"
             sh "ci/push.sh"
        }
      }
    }
    stage("sonar-code-analysis"){
      steps{
        script{
            withSonarQubeEnv(credentialsId: 'sonar-token') {
              sh "mvn sonar:sonar"
          }
        }
      }
    }
    stage("sonar-quality-check"){
      steps{
        script{
          waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
        }
      }
    }
    stage("Docker-login"){
      steps{
          sh "docker login -u chaan2835 -pChandra@2835"
          sh "docker build -t chaan2835/icici-jfrog-artifactory ."
          sh "docker push chaan2835/icici-jfrog-artifactory"
          sh "docker run -p 90:8080 -d --name icici-docker-image chaan2835/icici-jfrog-artifactory"
          /*script{
            def DOCKER_IMAGE_ID = sh(returnStdout: true, script: 'docker images --format "{{.ID}}" chaan2835/icici-jfrog-artifactory:latest').trim()
            
            sh "docker run -it --name icici-docker-jfrog $DOCKER_IMAGE_ID  /bin/bash, tty:true"
                 }*/
            }
        }
    }
}
