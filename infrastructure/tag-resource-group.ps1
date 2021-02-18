param ($resourceGroup, $tags)

$rgId = az group show --name $resourceGroup --query id

az tag create --resource-id $rgId --tags $tags