#!/bin/bash

echo "-----[argo rollout]-----"
kubectl get rollout
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