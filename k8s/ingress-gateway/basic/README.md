## Basic ingress-gateway example

```shell
$ kind create cluster
$ helm upgrade --install consul hashicorp/consul --version "1.2.3" --namespace consul --create-namespace --values ./values.yaml
$ kubectl apply -f resources
```

View the annotations added to the ingress-gateway pod as a result
```shell
$ kubectl get pods -n consul
$ kubectl get pod -n consul <pod_name_from_above_command> -o yaml | yq
```

Get the IP address of the ingress-gateway pod
```shell
$ kubectl get pod -n consul -o wide
```

To see the metrics endpoint, `curl` the IP address from above
```shell
$ curl http://<ip_address>:20200/metrics
```