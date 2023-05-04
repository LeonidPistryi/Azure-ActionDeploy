#!/usr/bin/env bash

# Install Tekton CLI
curl -LO https://github.com/tektoncd/cli/releases/download/v0.30.1/tkn_0.30.1_Darwin_all.tar.gz

# Extract tkn to your PATH (e.g. /usr/local/bin)
sudo tar xvzf tkn_0.30.1_Darwin_all.tar.gz -C /usr/local/bin tkn

# Install tasks from Tekton Hub
tkn hub install task git-clone && tkn hub install task buildah && tkn hub install task kubernetes-actions

# Install Tekton Pipelines
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

# Install Tekton Triggers
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml

# Install Tekton Dashboard
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/release.yaml

# Update Tekton Dashboard service to use LoadBalancer
kubectl patch service tekton-dashboard -n tekton-pipelines --type='json' -p '[{"op":"replace","path":"/spec/type","value":"LoadBalancer"}]'
