#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage("Deploy to Sock App") {
            steps {
                script {
                    dir('deploy/kubernetes') {
                        try{
                            sh "aws eks update-kubeconfig --name altschool-cluster"
                            sh "kubectl create -f complete-demo.yaml"
                        }
                        catch(error){
                            sh "kubectl apply -f complete-demo.yaml"
                        }

                    }
                }
            }
        }
    }
}