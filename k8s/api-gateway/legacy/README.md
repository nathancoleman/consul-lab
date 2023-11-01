## Legacy Consul API Gateway

https://github.com/hashicorp/consul-api-gateway

### Install

```shell
$ kubectl apply --kustomize "github.com/hashicorp/consul-api-gateway/config/crd?ref=v0.5.5"
$ helm upgrade --install consul hashicorp/consul --version="1.3.0-rc1" --values values.yaml --namespace consul --create-namespace
$ kubectl apply -f resources
```

### Test

Get the IP address for the Gateway:
```shell
$ kubectl get gateway api-gateway
```

Verify access to the backend service via the Gateway:
```shell
$ curl http://<ip_address>
```