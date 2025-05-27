pipeline {
    agent any
    parameters {
        booleanParam(name: 'confirm', defaultValue: false, description: 'Confirm to apply Terraform changes')
    }
    stages {
        stage('cloning the repo') {
            steps {
                echo "Cloning the repo"
                git branch: 'main', url: 'https://github.com/Rakshitsen/aws-terra.git'
            }
        }
        stage('terraform init and validate') {
            steps {
                withAWS(credentials: 'aws-jenkins-creds', region: 'us-east-2'){
                    echo "Initializing and validating Terraform"
                    sh 'terraform init'
                    sh 'terraform validate'
                }
            }
        }
        stage('terraform plan') {
            steps {
                echo "Generating Terraform plan"
                echo 'terraform plan'
            }
        }
        stage('terraform apply') {
            when {
                expression { params.confirm == true }
            }
            steps {
                echo "Applying Terraform changes"
                echo 'terraform apply -auto-approve'
            }
        }
    }
}
