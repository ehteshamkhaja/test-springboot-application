#!/bin/bash

cluster_name=test-eks-cluster
aws eks update-kubeconfig --name $cluster_name --region us-west-1

helmrelease="springboot-app"
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks

helmcheck=`helm list | grep $helmrelease`

if [ -z $helmcheck ]
then
  
  cd manifests  && helm install $helmrelease myspringboot-app
else 
   helm uninstall $helmrelease
   cd manifests  && helm install $helmrelease myspringboot-app
fi 

lbhelm=aws-load-balancer-controller
lbhelmname=`helm list | grep $lbhelm`
echo $lbhelmname
albcheck=`helm list | grep $lbhelmname`

#if [ -z $albcheck ]
#then 
  
#  helm install $lbhelm eks/aws-load-balancer-controller  -n kube-system --set clusterName=$cluster_name  --set serviceAccount.create=false  --set serviceAccount.name=aws-load-balancer-controller --set region=us-west-1 --set vpcId=vpc-06a9dc1f8d2f9a5b1
#else
#  helm uninstall $lbhelm
#  helm install $lbhelm eks/aws-load-balancer-controller  -n kube-system --set clusterName=$cluster_name  --set serviceAccount.create=false  --set serviceAccount.name=aws-load-balancer-controller --set region=us-west-1 --set vpcId=vpc-06a9dc1f8d2f9a5b1
#fi 

# helm install aws-load-balancer-controller eks/aws-load-balancer-controller  -n kube-system --set clusterName=$cluster_name  --set serviceAccount.create=false  --set serviceAccount.name=aws-load-balancer-controller --set region=us-west-1 --set vpcId=vpc-06a9dc1f8d2f9a5b1



  
