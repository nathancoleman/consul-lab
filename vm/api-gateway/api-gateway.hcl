kind = "api-gateway"
name = "my-gateway"
listeners = [
    {
        name = "https"
        port = "8443"
        protocol = "http"
        tls = {
            certificates = [
                {
                    kind = "file-system-certificate"
                    name = "fsc"
                }
            ]
        }
    }
]
