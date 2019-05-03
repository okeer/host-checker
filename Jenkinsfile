pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "okeer/hostchecker-backend"
    }
    stages {
        stage('Build sources') {
            steps {
                echo 'Running build automation'
                sh 'mvn compile war:war -X -U'
            }
        }
        stage('Run arquillian tests') {
            steps {
                echo 'Running tests'
                sh 'JBOSS_HOME=$JBOSS_HOME  mvn test -P arq-wildfly-managed'
            }
        }
        stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    app = docker.build(DOCKER_IMAGE_NAME)
                    app.inside {
                        sh 'echo test'
                    }
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('Deploy') {
            when {
                branch 'master'
            }
            steps {
                input 'It is really necessary to destroy the PROD?'
                milestone(1)
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'hostchecker.backend.yaml',
                    enableConfigSubstitution: true
                )
            }
        }
    }
}