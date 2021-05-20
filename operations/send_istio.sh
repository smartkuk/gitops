#!/bin/bash

minikube_ip=$(minikube ip)
http_port=$(kubectl get service -n istio-system istio-ingressgateway -o=jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')

echo "send request istio => http://${minikube_ip}:${http_port}/default/spring-boot-rest/app/name"
blue=$(curl http://${minikube_ip}:${http_port}/default/spring-boot-rest/app/name)
echo ">>> ${blue}"
echo ""

echo "send request istio(with http header) => http://${minikube_ip}:${http_port}/default/spring-boot-rest/app/name"
blue=$(curl -H "bxcr-user: smartkuk" http://${minikube_ip}:${http_port}/default/spring-boot-rest/app/name)
echo ">>> ${blue}"
echo ""
date