#!/bin/bash

minikube_ip=$(minikube ip)
while true
do
    echo "send service => http://${minikube_ip}:30081/app/name"
    blue=$(curl http://${minikube_ip}:30081/app/name)
    echo ">>> ${blue}"
    echo ""
    echo "wait 5s"
    sleep 5
    clear
done