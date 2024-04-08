kind = "http-route"
name = "my-route"
rules = [
    {
        services = [
            {
                name = "service-one"
            }
        ]
    }
]
parents = [
    {
        name = "my-gateway"
    }
]
