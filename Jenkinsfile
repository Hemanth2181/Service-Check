pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Run Service Check') {
            steps {
                sh 'chmod +x Service.sh'
                sh './Service.sh'
            }
        }
    }
}
