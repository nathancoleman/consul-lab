```shell
$ kubectl create namespace consul
$ create secret generic license --namespace consul --from-literal license='<consul_enterprise_license>'
$ helm upgrade --install consul hashicorp/consul --version="1.3.0" --namespace consul --values ./values.yaml

$ kubectl create namespace app
$ kubectl apply -f resources
```
