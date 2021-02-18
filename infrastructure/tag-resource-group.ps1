param ($resourceGroup, $owner, $environment)

$rgId = az group show --name $resourceGroup --query id

az tag create --resource-id $rgId --tags "Owner=${owner}" "Environment=${environment}" "ARM=true"