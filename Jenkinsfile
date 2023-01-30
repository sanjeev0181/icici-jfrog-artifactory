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
  }
}
