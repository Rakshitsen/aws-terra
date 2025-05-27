pipeline{
    agent any
    parameters {
     booleanParam(name: 'confirm', defaultValue: false, description: 'Confirm to apply Terraform changes')
    }
    stages {
        stage('cloning the repo'){
            steps{
                echo "Cloning the repo"
            }
        }
        stage('terraform init and validate'){
            steps{
                echo "Initializing and validating Terraform"
                echo 'terraform init'
                echo 'terraform validate'
            }
        }
        stage('terraform plan'){
            steps{
                echo "Generating Terraform plan"
                echo 'terraform plan'
            }
        }
        stage('terraform apply'){
            when {
                expression { params.confirm == true }
            }
            steps{
                echo "Applying Terraform changes"
                echo 'terraform apply -auto-approve'
            }
        }
    }
}
