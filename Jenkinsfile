pipeline {
    agent { label 'soham-jenkins-runner' }

    environment {
        EC2_USER = "ubuntu"  // Change for Ubuntu (e.g., ubuntu)
        EC2_IP = "3.225.1.206"
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
                sh 'mv target/restapidemo-0.0.1-SNAPSHOT.jar target/app.jar'
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh """
                        // sudo chown -R ubuntu:ubuntu /opt/myapp
                        // sudo chmod -R 755 /opt/myapp
                        scp -o StrictHostKeyChecking=no target/*.jar ${EC2_USER}@${EC2_IP}:/opt/myapp/app.jar
                        ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_IP} 'sudo systemctl restart myapp'
                    """
                }
            }
        }
    }
}
