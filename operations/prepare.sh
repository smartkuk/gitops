#!/bin/bash

minikube ip && minikube delete
minikube start --cpus=4 --memory=4096MB

curl -L https://istio.io/downloadIstio | sh -
pushd istio*/bin
  istioctl install --set profile=demo -y
popd

kubectl label namespace default istio-injection=enabled
kubectl apply -f /usr/local/bin/istio-1.9.5/samples/addons

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f https://raw.githubusercontent.com/argoproj/argo-rollouts/stable/manifests/install.yaml
kubectl apply -f ./internal_send_pod.yaml

while true
do
  kubectl get pods -n argocd | grep argocd-server | grep Running | grep "1/1"
  if [ "$?" == "0" ]; then
    break
  fi
  sleep 3;
done

kubectl patch service -n istio-system istio-ingressgateway -p '{"spec":{"type":"NodePort"}}'
kubectl get service -n istio-system istio-ingressgateway -o=jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}'

echo "run kubectl port-forward for argocd-server 8080 -> 443"
nohup kubectl port-forward svc/argocd-server -n argocd 8080:443 > /tmp/argocd-server.log 2>&1 &
nohup kubectl port-forward svc/kiali -n istio-system 20001:20001 > /tmp/kiali.log 2>&1 &
echo "argocd server init password:$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo)"

/usr/bin/google-chrome https://github.com/smartkuk/gitops
/usr/bin/google-chrome http://localhost:8080
/usr/bin/google-chrome http://localhost:20001
