pipeline {
    agent any

    // environment {
    //     EC2_USER = "ec2-user"  // Change for Ubuntu (e.g., ubuntu)
    //     EC2_IP = "<EC2_PUBLIC_IP>"
    //     SSH_KEY = credentials('ec2-ssh-key')  // Use Jenkins SSH key credentials
    // }

    stages {
        stage('Clone Repository') {
          steps {
            git branch: 'main',
              credentialsId: 'soham-gihub',
              url: 'git@github.com:sohampa/Jenkins-Aws-Deployment.git'
    }
}

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        // stage('Deploy to EC2') {
        //     steps {
        //         sshagent(['ec2-ssh-key']) {
        //             sh """
        //                 scp -o StrictHostKeyChecking=no target/*.jar ${EC2_USER}@${EC2_IP}:/opt/myapp/app.jar
        //                 ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_IP} 'sudo systemctl restart myapp'
        //             """
        //         }
        //     }
        // }
    }
}
