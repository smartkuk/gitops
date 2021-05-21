#!/bin/bash

minikube_ip=$(minikube ip)
curl -X POST http://${minikube_ip}:30081/client/metrics/reset
echo ""
curl http://${minikube_ip}:30081/client/metrics
echo ""