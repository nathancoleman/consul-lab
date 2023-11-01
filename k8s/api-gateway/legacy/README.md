## Legacy Consul API Gateway

https://github.com/hashicorp/consul-api-gateway

### Install

```shell
$ gcloud container clusters create cluster-1 --region=us-east1 --num-nodes=2 --cluster-version=1.25
$ kubectl apply --kustomize "github.com/hashicorp/consul-api-gateway/config/crd?ref=v0.5.5"
$ helm upgrade --install consul hashicorp/consul --version="1.2.2" --values values.yaml --namespace consul --create-namespace
$ kubectl apply -f resources
```

> [!NOTE]
> You may encounter a race condition and need to delete + recreate `resources/route.yaml` after the `Gateway` has settled.

### Test

Get the IP address for the Gateway:
```shell
$ kubectl get gateway api-gateway
```

Verify access to the backend service via the Gateway:
```shell
$ curl http://<ip_address>
```