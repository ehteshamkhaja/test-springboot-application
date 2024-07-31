#!/bin/bash

cluster_name=dev-eks-cluster
aws eks update-kubeconfig --name $cluster_name --region us-west-1
helmrelease="springboot-app"
cd manifests && helm install $helmrelease myspringboot-app  
