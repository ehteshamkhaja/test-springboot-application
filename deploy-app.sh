#!/bin/bash

cluster_name=test-eks-cluster
region=us-east-2

aws eks update-kubeconfig --name $cluster_name --region $region

releasename=spring


helm repo add eks https://aws.github.io/eks-charts
helm repo update eks

helmcheck=`helm list | grep $releasename | awk -F ' ' '{print $1}'`

if [[ -z $helmcheck ]]
then
  
  cd manifests  && helm install $releasename myspringboot-app
else 
   helm uninstall $helmrelease
   cd manifests  && helm install $releasename myspringboot-app
fi 
