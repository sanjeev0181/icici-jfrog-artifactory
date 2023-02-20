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
    stage("sonar report"){
      steps{
        script{
        publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/target/funds-1.0-SNAPSHOT/*.html', reportFiles: 'index.html',
                     reportName: 'Sonar-Html Report', reportTitles: '', useWrapperFileDirectly: true])
        }
      }
    }
    stage("Docker-login"){
      steps{
          sh "docker login -u chaan2835 -pChandra@2835"
          sh "docker build -t chaan2835/icici-jfrog-artifactory ."
          sh "docker push chaan2835/icici-jfrog-artifactory"
        script{
          def DOCKER_CONTAINER_PORT = env.BUILD_NUMBER.toInteger()
          echo "$DOCKER_CONTAINER_PORT"
          sh "docker run -p ${DOCKER_CONTAINER_PORT}:8080 -d --name ${env.JOB_NAME}-${env.BUILD_NUMBER} chaan2835/icici-jfrog-artifactory"
            }
        
          }
        }       
     }
}
