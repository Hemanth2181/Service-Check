FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html

stage('Test') {
    steps {
        echo 'Testing Docker image...'

        sh '''
            docker rm -f nginx-test || true

            docker run -d \
              --name nginx-test \
              -p 8081:80 \
              ${IMAGE_NAME}:${BUILD_NUMBER}

            sleep 5

            curl -f http://localhost:8081

            docker rm -f nginx-test
        '''
    }
}
