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
        stage('checkov') {
          steps{
            sh 'pipenv run pip install checkov'
            sh 'pipenv run checkov -d . --use-enforcement-rules -o cli -o junitxml --output-file-path console,results.xml --repo-id example/terragoat --branch main'
          }
        }
        stage('DEPLOYING TO STAGE') {
          steps{
            sh 'terraform apply -auto-approve'
          }
        }
    }
}