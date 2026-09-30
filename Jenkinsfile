pipeline {

    agent any

    environment {
        IMAGE_NAME = 'nginx-demo'
        CONTAINER_NAME = 'nginx-demo-container'
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out code from GitHub...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'

                sh '''
                    docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .
                    docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest
                '''
            }
        }

        stage('Test') {
            steps {
                echo 'Testing Docker image...'

                sh '''
                    docker run -d \
                      --name nginx-test \
                      ${IMAGE_NAME}:${BUILD_NUMBER}

                    sleep 5

                    curl -f http://localhost:80

                    docker stop nginx-test
                    docker rm nginx-test
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying Nginx application...'

                sh '''
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true

                    docker run -d \
                      --name ${CONTAINER_NAME} \
                      -p 80:80 \
                      ${IMAGE_NAME}:latest
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                echo 'Verifying Nginx deployment...'

                sh '''
                    sleep 3
                    curl -f http://localhost:80
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Nginx deployment successful!'
        }

        failure {
            echo '❌ Nginx deployment failed!'
        }

        always {
            sh 'docker ps -a'
        }
    }
}
