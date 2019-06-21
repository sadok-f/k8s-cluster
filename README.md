
### Set up the environment

    gcloud auth application-default login
    export GOOGLE_PROJECT=$(gcloud config get-value project)

### Run Terraform to create Kubernetes Cluster
    terraform init
    terraform plan
    terraform apply
