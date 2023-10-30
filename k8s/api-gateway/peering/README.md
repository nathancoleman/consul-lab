## Routing from an API gateway to a service imported from a peered cluster

### Prepare

#### Prepare dc1
```
$ gcloud container clusters create dc1 --region=us-east1 --num-nodes=2
$ helm upgrade --install consul hashicorp/consul --namespace=consul --create-namespace --values=values-dc1.yaml
$ kubectl apply --filename dc1
```


#### Prepare dc2
```
$ gcloud container clusters create dc2 --region=us-east1 --num-nodes=2
$ helm upgrade --install consul hashicorp/consul --namespace=consul --create-namespace --values=values-dc1.yaml
$ kubectl --context=dc1 get secret peering-token -n consul -o yaml | kubectl --context=dc2 apply -n consul -f -
$ kubectl apply --filename dc2
```

### Demonstrate

Get the IP address of the API gateway in dc1:
```
$ kubectl --context=dc1 get gateway api-gateway -n default -o yaml | yq .status.addresses
```

Make a `GET` request to the backend in the peered cluster - dc2 - via the `Gateway` in dc1:
```
$ curl http://<ip_address>
```