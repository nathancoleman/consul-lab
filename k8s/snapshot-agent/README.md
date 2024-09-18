## Prerequisites

### Log in with the Azure CLI
```shell
az login --tenant <tenant_id>
```

### Create a new Resource Group
```shell
az group create --name <resource_group_name> --location eastus
```


## Storage setup

### Create a new Storage Account in the Resource Group
```shell
az storage account create --name <storage_account_name> --resource-group <resource_group_name> --location eastus
```

### Create a new Storage Container in the Storage Account
```shell
az storage container create --name <storage_container_name> --account-name <storage_account_name> --auth-mode login
```

## Service Principal setup
### Create a new Service Principal
The Service Principal will need read and write access in the storage container that we created earlier.

Here, I am using the built-in role, `Storage Blob Data Contributor` ([docs](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#storage)).

Ensure you save the output of the following command. You will need these values to populate the constants in the script below.
```shell
az ad sp create-for-rbac --name <service_principal_name> --years 1 --role 'Storage Blob Data Contributor' --scopes subscriptions/<subscription_id>/resourceGroups/<resource_group_name>/providers/Microsoft.Storage/storageAccounts/<storage_account_name>/blobServices/default/containers/<storage_container_name>
```

## Upload a file to the Storage Container using the Service Principal
The constants in the following script need to be populated from the commands that we ran above.

```go
package main

import (
	"context"
	"fmt"
	"log/slog"
	"os"

	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	"github.com/Azure/azure-sdk-for-go/sdk/storage/azblob"
)

const (
	principalID       = "<app_id_from_sp_create>"
	principalPassword = "<password_from_sp_create>"
	tenantID          = "<tenant_id>"

	storageAccount   = "<storage_account_name>"
	storageContainer = "<storage_container_name>"
)

func main() {
	// Create a credential using the ID and secret for our Service Principal
	credential, err := azidentity.NewClientSecretCredential(tenantID, principalID, principalPassword, nil)
	if err != nil {
		slog.Error("failed to construct credential", "error", err)
		os.Exit(1)
	}

	// Create a blob service client
	serviceURL := fmt.Sprintf("https://%s.blob.core.windows.net/", storageAccount)
	client, err := azblob.NewClient(serviceURL, credential, nil)
	if err != nil {
		slog.Error("failed to create blob service client", "error", err)
		os.Exit(1)
	}

	// Create the content for our file upload
	filename := "hello.txt"
	content := "Hello, World!"

	// Upload the content to the container
	_, err = client.ServiceClient().
		NewContainerClient(storageContainer).
		NewBlockBlobClient(filename).
		UploadBuffer(context.Background(), []byte(content), nil)
	if err != nil {
		slog.Error("failed to upload content", "error", err)
		os.Exit(1)
	}

	slog.Info("content uploaded successfully")
}
```