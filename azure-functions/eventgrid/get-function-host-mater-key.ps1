param(
    [Parameter(Mandatory = $true)]
    [string]
    $ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [string]
    $functionAppName
)

$creds = Invoke-AzureRmResourceAction -ResourceGroupName $resourceGroupName `
	-ResourceType Microsoft.Web/sites/config -ResourceName "$functionAppName/publishingcredentials" `
	-Action list -ApiVersion 2015-08-01 -Force

$username = $creds.Properties.PublishingUserName
$password = $creds.Properties.PublishingPassword
$kuduAuthToken = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username, $password)))

$apiUrl = "https://$functionAppName.scm.azurewebsites.net/api/functions/admin/masterkey"
$result = Invoke-RestMethod -Uri $apiUrl -Headers @{"Authorization"="Basic $kuduAuthToken";"If-Match"="*"} 
$masterKey = $result.masterKey

Write-Output ("##vso[task.setvariable variable=EventGridFunctionMasterKey;]$masterKey")

return $masterKey