## Basic API Gateway

### Install

```shell
$ helm upgrade --install consul hashicorp/consul --values values.yaml
$ kubectl apply -f resources
```

### Test

Get the IP address of the Gateway:
```shell
$ kubectl get gateway api-gateway --namespace default
```

Curl the Gateway to verify that you can read the Backend service through it:
```shell
$ curl http://<ip_address>
```