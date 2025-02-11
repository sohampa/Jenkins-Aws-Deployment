pipeline {
    agent { label 'soham-jenkins-agent' }

    environment {
        EC2_USER = "ubuntu"  // Change for Ubuntu (e.g., ubuntu)
        EC2_IP = "18.205.235.103"
        SSH_KEY = credentials('ec2-ssh-key')  // Use Jenkins SSH key credentials
    }

    stages {
        stage('Clone Repository') {
          steps {
            git branch: 'main',
              url: 'https://github.com/sohampa/Jenkins-Aws-Deployment.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Deploy to EC2') {
            steps {
                withCredentials([string(credentialsId: 'ec2-ssh-key', variable: 'PEM_CONTENT')]) {
                    script {
                        // SSH command using the private key
                        sh """
                            echo "\$PEM_CONTENT" > temp.pem
                            chmod 600 temp.pem
                            ssh -o StrictHostKeyChecking=no -i temp.pem ubuntu@18.205.235.103 'sudo systemctl restart nginx'
                            rm -f temp.pem
                        """
                    }
                }
            }
        }
        
    }
}
