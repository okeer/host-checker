pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "okeer/hostchecker-backend"
        CANARY_REPLICAS = 0
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
        stage('UAT Deploy') {
            when {
                branch 'master'
            }
            environment {
                CANARY_REPLICAS = 1
            }
            steps {
                   kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'hostchecker.backend.canary.yaml',
                    enableConfigSubstitution: true
                )
            }
        }
        stage('SmokeTestUAT') {
            when {
                branch 'master'
            }
            steps {
                script {
                    sleep (time: 10)
                    def response = httpRequest (
                        url: "http://hostchecker-backend-canary-service:8082/checker/api/request/http://google.com",
                        timeout: 30
                    )
                    if (response.status != 200) {
                        error("Smoke test against canary deployment failed.")
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
    post {
        cleanup {
            kubernetesDeploy (
                    kubeconfigId: 'kubeconfig',
                    configs: 'hostchecker.backend.canary.yaml',
                    enableConfigSubstitution: true
                )
            }
    }
}
