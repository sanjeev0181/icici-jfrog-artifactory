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
             sh "curl -u${ARTIFACTORY_USER}:${ARTIFACTORY_PASSWORD} -X PUT \"http://13.235.242.216:8081/artifactory/webapp/libs-snapshot-local/${env.BUILD_NUMBER}/my-artifact-${env.BUILD_NUMBER}.jar\" -T funds-1.0-SNAPSHOT.war"
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
          }
      }
    }
}
