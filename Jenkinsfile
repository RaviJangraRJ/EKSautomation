pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION    = 'us-east-1'
        RJ_APPLICATION = 'RJ'
    }
    stages {
        stage('Show the environment') {
            steps {
                echo "Application name is ${env.RJ_APPLICATION}"
                echo "Build ID is ${env.BUILD_ID}"
            }
        }
        stage('Git Checkout') {
            steps {
                git branch: 'main', credentialsId: 'foodiesPat', url: 'https://github.com/RaviJangraRJ/EKSjenkins.git'
            }
        }

        stage('Terraform Init and Apply') {
            steps {
                script {
                    def terraformDir = 'EKS'
                    
                    sh """
                        cd ${terraformDir}
                        AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID} AWS_SECRET_ACCESS_KEY=${env.AWS_SECRET_ACCESS_KEY} sudo terraform init
                        AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID} AWS_SECRET_ACCESS_KEY=${env.AWS_SECRET_ACCESS_KEY} sudo terraform destroy -auto-approve
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Terraform apply succeeded!'
        }
        failure {
                script {
                    def terraformDir = 'EKS'

                    sh """
                        cd ${terraformDir}
                        AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID} AWS_SECRET_ACCESS_KEY=${env.AWS_SECRET_ACCESS_KEY} sudo terraform init
                        AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID} AWS_SECRET_ACCESS_KEY=${env.AWS_SECRET_ACCESS_KEY} sudo terraform apply -auto-approve
                    """
                }
        }
    }
}
