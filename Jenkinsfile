pipeline {
    agent {  Terraform
        node {
            label 'Terraform-agent'
            }
      }
    triggers {
        pollSCM '* * * * *'
    }
    stages {
        stage('Build') {
            steps {
                echo "Building.."
                sh '''
                terraform apply E-Commerce-Project
                
                '''
            }
        }
        
    }
}