# Brief 
Create a Kubernetes secret to hold the server’s certificate and private key. Use kubectl to create the secret istio-ingressgateway-certs in namespace istio-system . The Istio gateway will load the secret automatically.

```
kubectl exec -it -n istio-system $(kubectl -n istio-system get pods -l istio=ingressgateway -o jsonpath='{.items[0].metadata.name}') -- ls -al /etc/istio/ingressgateway-certs
```

