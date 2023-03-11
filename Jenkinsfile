#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('deploy/kubernetes') {
                        sh "aws eks update-kubeconfig --name altschool-cluster"
                        sh "kubectl create -f complete-demo.yaml"

                    }
                }
            }
        }
    }
}