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
        withCredentials([sshUserPrivateKey(credentialsId: 'ec2-ssh-key', keyFileVariable: 'PEM_FILE', usernameVariable: 'SSH_USER')]) {
            script {
                def JAR_FILE = "target/restapidemo-0.0.1-SNAPSHOT.jar"  // Path of JAR file
                def REMOTE_DIR = "/home/ubuntu"  // Remote directory
                def REMOTE_SERVER = "18.205.235.103"

                // Debugging: Print variable values
                sh """
                    echo "JAR_FILE: $JAR_FILE"
                    echo "REMOTE_DIR: $REMOTE_DIR"
                    echo "REMOTE_SERVER: $REMOTE_SERVER"
                    echo "PEM_FILE: $PEM_FILE"
                """

                // Ensure JAR file exists
                sh "ls -l ${JAR_FILE} || echo 'JAR file not found'"

                // Securely copy JAR file to EC2
                sh """
                    scp -o StrictHostKeyChecking=no -i "\$PEM_FILE" "\${JAR_FILE}" ubuntu@18.205.235.103:/home/ubuntu/app/
                """

                // SSH into EC2 and check the file
                sh """
                    ssh -o StrictHostKeyChecking=no -i "\$PEM_FILE" "\$SSH_USER@\$REMOTE_SERVER" '
                    cd $REMOTE_DIR &&
                    ls -lh restapidemo-0.0.1-SNAPSHOT.jar &&
                    sudo pwd'
                """
            }
        }
    }
}

        
    }
}
