#!/bin/bash

minikube_ip=$(minikube ip)

echo "send request to blue => http://${minikube_ip}:30081/app/name"
blue=$(curl http://${minikube_ip}:30081/app/name)
echo ">>> ${blue}"
echo ""

echo "send request to green => http://${minikube_ip}:30082/app/name"
green=$(curl http://${minikube_ip}:30082/app/name)
echo ">>> ${green}"
echo ""
date