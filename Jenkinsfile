pipeline {
    agent any
    options {
        // Timeout counter starts AFTER agent is allocated
        timeout(time: 1, unit: 'HOURS')
    }
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'
            }
        }
        stage('Checkingout git repo') {
             steps {
                git branch: 'main', url:'https://github.com/582Bamfo/test-cicd.git'
             }
        }
        stage('INITIALISATION') {
              steps{
                sh 'terraform init'
              }
        }
        stage('PLANNING') {
          steps{
            sh 'terraform plan'
          }
        }
        stage('tfsec') {
           agent {
             docker { 
               image 'tfsec/tfsec-ci:v0.57.1' 
               reuseNode true
             }
           }
            steps {
             sh '''
              tfsec . --no-color
            '''
      }
    }

    stage("deploy") {
      steps{
        sh 'terraform apply -auto-approve'
      }
    }
          
         }
        
    }
