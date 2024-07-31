#!/bin/bash

cluster_name=dev-eks-cluster
aws eks update-kubeconfig --name $cluster_name --region us-west-1

helmrelease="springboot-app"
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks

lbhelm=aws-load-balancer-controller
lbhelmname=`helm list | grep $lbhelm`
echo $lbhelmname

helm uninstall $lbhelm 
helm uninstall $helmrelease

if [ -z "$lbhelmname" ]
then
     helm install $lbhelm eks/aws-load-balancer-controller  -n kube-system --set clusterName=$cluster_name  --set serviceAccount.create=false  --set serviceAccount.name=aws-load-balancer-controller --set region=us-west-1 --set vpcId=vpc-06a9dc1f8d2f9a5b1
else
     cd manifests && helm uninstall $lbhelm 
     helm install $lbhelm eks/aws-load-balancer-controller  -n kube-system --set clusterName=$cluster_name  --set serviceAccount.create=false  --set serviceAccount.name=aws-load-balancer-controller --set region=us-west-1 --set vpcId=vpc-06a9dc1f8d2f9a5b1

fi


# helm install aws-load-balancer-controller eks/aws-load-balancer-controller  -n kube-system --set clusterName=$cluster_name  --set serviceAccount.create=false  --set serviceAccount.name=aws-load-balancer-controller --set region=us-west-1 --set vpcId=vpc-06a9dc1f8d2f9a5b1

var=`helm list | grep $helmrelease`
echo $var
if [ -z "$var" ]
then
     cd manifests && helm install $helmrelease myspringboot-app
else
     cd manifests && helm uninstall $helmrelease && helm install $helmrelease myspringboot-app
fi

  
