### install the tools
    brew install jq

### Set up the environment

    gcloud auth application-default login
    export GOOGLE_PROJECT=$(gcloud config get-value project)

### General service-account.json
    gcloud iam service-accounts keys create service-account.json --iam-account k8s-773@kiwi-k8s-244506.iam.gserviceaccount.com

### Run Terraform to create Kubernetes Cluster
    terraform init
    terraform plan
    terraform apply

### Get the cluster configuration for Kubectl
    gcloud container clusters get-credentials kiwi-dev
    
### Check the cluster node
    kubectl get nodes -o wide
    
### Lorem-go Application


[https://github.com/sadok-f/lorem-go](https://github.com/sadok-f/lorem-go)

### Deploy Lorem-go application to K8S Cluster
    kubectl apply -f lorem-deployment.yaml