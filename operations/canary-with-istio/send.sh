#!/bin/bash

minikube_ip=$(minikube ip)
http_port=$(kubectl get service -n istio-system istio-ingressgateway -o=jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')

echo "send request istio => http://${minikube_ip}:${http_port}/default/spring-boot-rest/app/name"
blue=$(curl http://${minikube_ip}:${http_port}/default/spring-boot-rest/app/name)
echo ">>> ${blue}"
echo ""

# blue_ip=$(kubectl get pods --field-selector metadata.name!=nginx -o json | jq '.items[] | select(.spec.containers[].image == "smartkuk/spring-boot-rest:blue") | .status.podIP')
# green_ip=$(kubectl get pods --field-selector metadata.name!=nginx -o json | jq '.items[] | select(.spec.containers[].image == "smartkuk/spring-boot-rest:green") | .status.podIP')
# blue_res=$(kubectl exec -it nginx -c nginx -- curl http://${blue_ip//\"/}:8080/client/metrics)
# green_res=$(kubectl exec -it nginx -c nginx -- curl http://${green_ip//\"/}:8080/client/metrics)
# echo "${blue_res}"
# echo "${green_res}"
# echo ""
date