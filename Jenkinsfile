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
        stage("Apply the clusterRole config"){
            steps{
                script {
                    dir('deploy/prometheus') {
                        try{
                            sh "kubectl create -f clusterRole.yaml"
                        }
                        catch(error){
                            sh "kubectl apply -f clusterRole.yaml"
                        }

                    }
                }
            }
        }
        stage("Deploy prometheus to kubernetes"){
            steps{
                script {
                    dir('deploy/prometheus') {
                        try{
                            sh "kubectl create -f prometheus-deployment.yaml"
                        }
                        catch(error){
                            sh "kubectl apply -f prometheus-deployment.yaml"
                        }

                    }
                }
            }
        }
        stage("Deploy prometheus service to kubernetes"){
            steps{
                script {
                    dir('deploy/prometheus') {
                        try{
                            sh "kubectl create -f prometheus-service.yaml"
                        }
                        catch(error){
                            sh "kubectl apply -f prometheus-service.yaml"
                        }

                    }
                }
            }
        }
        stage("Setting up Kube State Metrics on Kubernetes"){
            steps{
                script {
                    dir('deploy/prometheus') {
                            sh "git clone https://github.com/devopscube/kube-state-metrics-configs.git"
                            sh "kubectl apply -f kube-state-metrics-configs/"
                    }
                }
            }
        }
        stage("Create configmap for grafana"){
            steps{
                script {
                    dir('deploy/prometheus') {
                        try{
                            sh "kubectl create -f grafana-datasource-config.yaml"
                        }
                        catch(error){
                            sh "kubectl apply -f grafana-datasource-config.yaml"
                        }

                    }
                }
            }
        }
        stage("Deploy grafana"){
            steps{
                script {
                    dir('deploy/prometheus') {
                        try{
                            sh "kubectl create -f grafana-deployment.yaml"
                        }
                        catch(error){
                            sh "kubectl apply -f grafana-deployment.yaml"
                        }

                    }
                }
            }
        }
        stage("Deploy grafana service "){
            steps{
                script {
                    dir('deploy/prometheus') {
                        try{
                            sh "kubectl create -f grafana-service.yaml"
                        }
                        catch(error){
                            sh "kubectl apply -f grafana-service.yaml"
                        }

                    }
                }
            }
        }
    }
}