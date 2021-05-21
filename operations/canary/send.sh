#!/bin/bash

minikube_ip=$(minikube ip)

echo "send request => http://${minikube_ip}:30081/app/name"
blue=$(curl http://${minikube_ip}:30081/app/name)
echo ">>> ${blue}"
echo ""
date