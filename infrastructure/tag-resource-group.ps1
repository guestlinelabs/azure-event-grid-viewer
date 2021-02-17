param ($resourceGroupName, $tags)

$rgId = az group show --name pms-eventgrid-viewer-ci-rg --query id

az tag create --resource-id $rgId --tags $tags