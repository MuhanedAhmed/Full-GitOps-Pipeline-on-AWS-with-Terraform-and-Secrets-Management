pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        AWS_ACCOUNT_ID = '991424600343'
        ECR_REPO_NAME = 'nodejs-app'
        IMAGE_TAG = 'latest'
        ECR_REGISTRY = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
        DOCKER_IMAGE = "${ECR_REGISTRY}/${ECR_REPO_NAME}:${IMAGE_TAG}"
        APP_REPO = 'https://github.com/mahmoud254/jenkins_nodejs_example'
        APP_BRANCH = 'master'
    }

    stages {
        stage('Clone Node.js App') {
            steps {
                script {
                    sh 'rm -rf nodejs_app'
                    sh 'git clone -b $APP_BRANCH $APP_REPO nodejs_app'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('nodejs_app') { 
                    sh "docker build -t ${ECR_REPO_NAME}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Login to Amazon ECR') {
    steps {
        
            sh '''
                aws ecr get-login-password --region $AWS_REGION | \
                docker login --username AWS --password-stdin $ECR_REGISTRY
            '''
        
    }
}

        stage('Tag and Push Image to ECR') {
            steps {
                sh """
                    docker tag ${ECR_REPO_NAME}:${IMAGE_TAG} ${DOCKER_IMAGE}
                    docker push ${DOCKER_IMAGE}
                """
            }
        }
    }

    post {
        success {
            echo 'CI Pipeline finished successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs.'
        }
    }
}