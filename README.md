# K8S Ingress (Nginx)
## Launching the nginx controller
```
kubectl apply -f nginx/manifest.yaml
```

## Applying ingress
```
kubectl apply -f k8s/ingress.yaml
```

# Production for GKE
### `release` contains manifest for production.
### Follow these specific steps
1. [Configure cluster access for kubectl](#Configure-cluster-access-for-kubectl)
2. [Create the GKE Cluster Admin ClusterRole](#create-the-gke-cluster-admin-clusterrole)
3. [Deploy Nginx Controller](#deploy-nginx-controller)
4. [Deploy Cert manager (TLS/SSL) - LetsEncrypt](#deploy-cert-manager-tlsssl---letsencrypt)
5. [Pulling from a private repository - I.E Gitlab secrets](#pulling-from-a-private-repository---ie-gitlab-secrets)
6. [Apply ingress rules](#apply-ingress-rules)

## Configure cluster access for `kubectl`
Configure 
```
gcloud config set project [project_id]

gcloud config set compute/zone [asia-southeast1-a]

gcloud config set compute/region [asia-southeast1-a]

gcloud components update

gcloud container clusters get-credentials [kinddd cluster]
```

## Create the GKE Cluster Admin ClusterRole
GKE cluster admin
```
kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user $(gcloud config get-value account)
```

## Deploy Nginx Controller
#### Useful links
- [Kubernetes Nginx Deployment](https://kubernetes.github.io/ingress-nginx/deploy)
- [Kubernetes Nginx Annotations](https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/#configuration-snippet)

#### The following Mandatory Command is required.
```
kubectl apply -f nginx/manifest.yaml
```

For the latest updates
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml
```

Loadbalancer for GKE to expose port
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/cloud-generic.yaml
```
**If you are using a Kubernetes version previous to 1.14, you need to change kubernetes.io/os to beta.kubernetes.io/os at line 217 of mandatory.yaml, see Labels details.**


## Deploy Cert manager (TLS/SSL) - LetsEncrypt
#### Useful links
- [LetsEncrypt Docs](https://docs.cert-manager.io/en/latest/getting-started/install.html)

#### The following Mandatory Command is required for deployments
```
kubectl create namespace cert-manager

kubectl label namespace cert-manager cert-manager.k8s.io/disable-validation=true

kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v0.11.0/cert-manager.yaml --validate=false

```

## Pulling from a private repository - I.E Gitlab secrets
Execute the command depending on your use cases

#### Create a Secret by providing credentials on the command line
```
kubectl create secret docker-registry [NAME] --docker-server=registry.gitlab.com --docker-username=isaiahwong --docker-password=PASSWORD --docker-email=EMAIL
```

#### Create the manifest file - I.E Seting a namespace or a label on the new secret - 
```
kubectl create secret docker-registry NAME -o yaml --dry-run  --docker-server=registry.gitlab.com --docker-username=isaiahwong --docker-password=PASSWORD --docker-email=EMAIL > registry-credentials.yaml
```

#### macOS - Copies manifest to clipboard
```
kubectl create secret docker-registry NAME -o yaml --dry-run  --docker-server=registry.gitlab.com --docker-username=isaiahwong --docker-password=PASSWORD --docker-email=EMAIL | pbcopy
```

## Apply ingress rules
#### Applying ingress
```
kubectl apply -f release/ingress.yaml
```