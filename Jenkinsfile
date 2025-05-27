pipeline{
    agent any
    
    parameters {
        booleanParams(name: 'Plan_Infrastructure', defaultValue: false, description: 'Check the Planning of Infra')
        booleanParams(name: 'Apply_Infrastructure', defaultValue: false, description: 'Check the Applying of Infra')
        booleanParams(name: 'Destroy_Infrastructure', defaultValue: false, description: 'Check the Destroying of Infra')
    }
    
    stages {
        stage('Cloning the repository') {
            steps {
                git 'https://github.com/Rakshitsen/aws-terra.git'
            }
        }
        stage('Terraform Init') {
            steps {
                 withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-jenkins-creds', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh 'echo =============================Terraform Init==================================='
                        sh 'terraform init'
            }
            
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    if (params.Plan_Infrastructure) {
                        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-jenkins-creds', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                            sh 'echo =============================Terraform Plan==================================='
                            sh 'terraform plan'
                        } 
                    }
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                script {
                    if (paras.Apply_Infrastructure) {
                        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-jenkins-creds', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                            sh 'echo =============================Terraform Apply==================================='
                            sh 'terraform apply'
                        } 
                    }
                }
            }
        }
        stage('Terraform Destroy') {
            steps {
                script {
                    if (params.Destroy_Infrastructure) {
                        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-jenkins-creds', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                            sh 'echo =============================Terraform destroy==================================='
                            sh 'terraform destroy'
                        } 
                    }
                }
            }
        }
    }
}
