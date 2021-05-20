#!/bin/bash

echo "-----[argo argocd/applications]-----"
kubectl get applications -n argocd
echo ""

echo "-----[argo rollout]-----"
kubectl get rollout
echo ""

echo "-----[istio virtual service]-----"
kubectl get vs
echo ""

echo "-----[k8s service]-----"
kubectl get service
echo ""

echo "-----[k8s deployment]-----"
kubectl get deployment
echo ""

echo "-----[k8s replicaset]-----"
kubectl get rs
echo ""

echo "-----[k8s pods]-----"
kubectl get pods
echo ""