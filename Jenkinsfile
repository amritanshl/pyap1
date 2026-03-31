pipeline {
    agent any

    environment {
        // Bypass Mac Desktop credentials error
        DOCKER_CONFIG = '/tmp'
        // Absolute path to Docker executable
        DOCKER_BIN = '/usr/local/bin/docker'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                echo '--- STARTING CI/CD PIPELINE ---'
                echo 'Building Docker Image from GitHub source...'
                
                sh "${DOCKER_BIN} build -t my-python-webapp1:latest ."
            }
        }
        
        stage('Clean Environment') {
            steps {
                echo 'Removing old container if it exists...'
                
                sh "${DOCKER_BIN} rm -f python-app-container1 || true"
            }
        }

        stage('Deploy Application') {
            steps {
                echo 'Starting new container with SQLite volume mapping...'
                
                // The -v app-db-data:/data flag ensures your database survives container restarts
                sh "${DOCKER_BIN} run -d -p 5001:5000 -v app-db-data:/data --name python-app-container1 my-python-webapp1:latest"
                
                echo '--- DEPLOYMENT COMPLETE ---'
            }
        }
    }
    
    post {
        success {
            echo " SUCCESS! App is live at http://localhost:5002"
            echo " Check your Grafana dashboard to see the pipeline metrics!"
        }
        failure {
            echo " FAILED! Check the console output above to debug the error."
        }
    }
}