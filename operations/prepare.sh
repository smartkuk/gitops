#!/bin/bash

minikube ip && minikube delete
minikube start
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled
kubectl apply -f /usr/local/bin/istio-1.9.5/samples/addons

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f https://raw.githubusercontent.com/argoproj/argo-rollouts/stable/manifests/install.yaml

while true
do
  kubectl get pods -n argocd | grep argocd-server | grep Running | grep "1/1"
  if [ "$?" == "0" ]; then
    break
  fi
  sleep 3;
done

echo "run kubectl port-forward for argocd-server 8080 -> 443"
nohup kubectl port-forward svc/argocd-server -n argocd 8080:443 > /tmp/argocd-server.log 2>&1 &
nohup kubectl port-forward svc/kiali -n istio-system 20001:20001 > /tmp/kiali.log 2>&1 &
echo "argocd server init password:$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo)"

chrome https://github.com/smartkuk/gitops
chrome http://localhost:8080
chrome http://localhost:20001
