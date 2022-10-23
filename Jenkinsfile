pipeline {
    
    environment {
            DOCKERHUB_CREDENTIALS = credentials('jerichomb-dockerhub')
        }
    agent { any { image 'python:3.9' } }
    stages {
        stage('Clear processes') {
            steps {
                echo "-=- clear processes -=-"
                sh "docker stop \044(docker ps -a -q)"
                sh "docker rm \044(docker ps -a -q)"
            }
        } 
        stage('Get files') {
            steps {
                echo "-=- get files -=-"
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/jerichoma/webproject.git']]])
            }
        }
        stage('Build Docker image') {
            steps {
                echo "-=- build Docker image -=-"
                sh "docker build -t python-web:latest ."
            }
        }
        stage('Run Docker image') {
            steps {
                echo "-=- run Docker image -=-"
                sh "docker run -d -p 8000:8000 python-web"
            }
        } 
        
        stage('Push to Dockerhub') {
            steps {
                echo "-=- push to Dockerhub -=-"
                sh "docker tag python-web:latest jerichomb/webserver:latest"
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker push jerichomb/webserver:latest"
            }
        }    
    }
}
