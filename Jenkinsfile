pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'nginx-portfolio'
        DOCKER_CONTAINER = 'nginx-portfolio-container'
        DOCKER_REGISTRY = 'aayushaj112'
    }
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }
        stage('Test Docker Image') {
            steps {
                script {
                   
                    sh "docker run --rm -d --name ${DOCKER_CONTAINER} -p 8081:80 ${DOCKER_IMAGE}"
                    sh "sleep 5"  // Give the container time to start
                    sh "curl -f http://localhost:8081 || exit 1"
                }
            }
        }
        stage('Push to Docker Hub') {
    steps {
        withCredentials([string(credentialsId: 'docker-hub-token', variable: 'DOCKER_TOKEN')]) {
            script {
                sh '''
                echo "${DOCKER_TOKEN}" | docker login -u aayushaj112 --password-stdin
                docker tag nginx-portfolio aayushaj112/nginx-portfolio:latest
                docker push aayushaj112/nginx-portfolio:latest
                '''
            }
        }
    }
}
        stage('Deploy to Production') {
            steps {
                script {
                    sh """
                    docker rm -f ${DOCKER_CONTAINER} || true
                    docker run -d --name ${DOCKER_CONTAINER} -p 80:80 ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:latest
                    """
                }
            }
        }
    }
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}

