#!/bin/bash

cluster_name=dev-eks-cluster
aws eks update-kubeconfig --name $cluster_name --region us-west-1

helmrelease="springboot-app"
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks

lbhelm=aws-load-balancer-controller
lbhelmname=`helm list | grep $lbhelm`
echo $lbhelmname
cd manifests && helm uninstall $helmrelease && helm install $helmrelease myspringboot-app


helm install $lbhelm eks/aws-load-balancer-controller  -n kube-system --set clusterName=$cluster_name  --set serviceAccount.create=false  --set serviceAccount.name=aws-load-balancer-controller --set region=us-west-1 --set vpcId=vpc-06a9dc1f8d2f9a5b1



# helm install aws-load-balancer-controller eks/aws-load-balancer-controller  -n kube-system --set clusterName=$cluster_name  --set serviceAccount.create=false  --set serviceAccount.name=aws-load-balancer-controller --set region=us-west-1 --set vpcId=vpc-06a9dc1f8d2f9a5b1



  
