This is a test setup for API gateway on VMs using the file-system-certificate configuration entry.

You will need to run Consul and the API gateway Envoy process in separate terminal sessions locally.

```shell
make dev-build

consul agent -dev
```

```shell
# Write all of the necessary config entries
consul config write proxy-defaults.hcl
consul config write file-system-certificate.hcl
consul config write api-gateway.hcl
consul config write route.hcl

# Run the API gateway process
consul connect envoy -gateway api -register -service my-gateway -proxy-id my-gateway -- -l trace
```
