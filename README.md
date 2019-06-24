### install the tools
    brew install jq

Install t he [Google Cloud SDK](https://cloud.google.com/sdk/docs/quickstart-macos)

### Set up the environment

    gcloud auth application-default login
    export GOOGLE_PROJECT=$(gcloud config get-value project)

### General service-account.json
Create new Service Accounts from [GCP Console](https://console.cloud.google.com/iam-admin/serviceaccounts) and generate the service-account.json after that:

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
    
### Content of lorem-deployment.yaml
```yaml
    ## Application Deployment Object
    apiVersion: extensions/v1beta1
    kind: Deployment
    metadata:
      name: lorem-go
      labels:
        app: lorem-go
    spec:
      replicas: 2
      strategy:
        type: RollingUpdate
        rollingUpdate:
          maxUnavailable: 50%
          maxSurge: 1
      template:
        metadata:
          labels:
            app: lorem-go
        spec:
          containers:
          - name: lorem-go
            image: docker.io/sadokf/lorem-go:0.0.1
            imagePullPolicy: Always
            ports:
            - containerPort: 3000
            livenessProbe:
              httpGet:
                path: /healthz
                port: 3000
            readinessProbe:
              httpGet:
                path: /readyz
                port: 3000
            resources:
              limits:
                cpu: 10m
                memory: 30Mi
              requests:
                cpu: 10m
                memory: 30Mi
                
## Service Object, type: NodePort
    apiVersion: v1
    kind: Service
    metadata:
      name: lorem-go
      labels:
        app: lorem-go
    spec:
      type: NodePort
      ports:
      - port: 3000
        targetPort: 3000
        protocol: TCP
        name: http
      selector:
        app: lorem-go
        
## Ingress Object
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: lorem-go
    spec:
      backend:
        serviceName: lorem-go
        servicePort: 3000

```
### Accessing the application

[http://34.98.104.20/](http://34.98.104.20/)