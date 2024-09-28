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
        stage('Checkov') {
             steps {
                 script {
                     docker.image('bridgecrew/checkov:latest').inside("--entrypoint=''") {
                         unstash 'terragoat'
                         try {
                             sh 'checkov -d . --use-enforcement-rules -o cli -o junitxml --output-file-path console,results.xml --repo-id example/terragoat --branch main'
                             junit skipPublishingChecks: true, testResults: 'results.xml'
                         } catch (err) {
                             junit skipPublishingChecks: true, testResults: 'results.xml'
                             throw err
                         }
                     }
                 }
             }
         }
        stage('DEPLOYING TO STAGE') {
          steps{
            sh 'terraform apply -auto-approve'
          }
        }
    }
}