param ($appName, $resourceGroup, $tenantId)


$uri = "https://${appName}.azurewebsites.net"
$issuer = "https://sts.windows.net/${tenantId}/"
$replyUri = "${uri}/.auth/login/aad/callback"

$appId = az ad app create --display-name $appName  --identifier-uris $uri --reply-urls $replyUri -o json --query appId

$clientSecret = az ad app credential reset --id $appId -o json --query password

az webapp auth update -g $resourceGroup -n $appName --enabled true --action LoginWithAzureActiveDirectory --aad-client-id $appId --aad-token-issuer-url $issuer --token-store true  --aad-allowed-token-audiences $uri --aad-client-secret $clientSecret


# --api 00000003-0000-0000-c000-000000000000 == MS Graph AAD application id
# --api-permissions e1fe6dd8-ba31-4d61-89e7-88639da4683d == User.Read permission

# Remove all permissions then re-add.

az ad app permission delete --id $appId

az ad app permission add --id $appId --api 00000003-0000-0000-c000-000000000000 --api-permissions e1fe6dd8-ba31-4d61-89e7-88639da4683d=Scope