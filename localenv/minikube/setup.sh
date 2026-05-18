#!/bin/bash

set -euo pipefail

echo "Starting minikube"
minikube start

echo "Setting up ArgoCD helm charts"
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm repo update

echo "Deploying ArgoCD"
helm upgrade --install argo-cd ../argo-cd/repo/charts/argocd/ --namespace argocd --create-namespace
kubectl delete secret -n argocd -l "owner=helm,name=argo-cd"

echo "Starting ArgoCD default structure"
kubectl apply -f ../argo-cd/repo/apps/default.yml
