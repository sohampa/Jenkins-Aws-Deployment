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
                withCredentials([sshUserPrivateKey(credentialsId: 'ec2-ssh-key', keyFileVariable: 'PEM_FILE')]) {
                    script {
                        sh """
                            ssh -o StrictHostKeyChecking=no -i "\$PEM_FILE" ubuntu@18.205.235.103 'sudo systemctl restart nginx'
                        """
                    }
                }
            }
        }
        
    }
}
