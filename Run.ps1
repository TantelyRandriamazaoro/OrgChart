param(
    [Parameter(Mandatory = $true)]
    [string]$tenantId,

    [Parameter(Mandatory = $true)]
    [string]$clientId,

    [Parameter(Mandatory = $true)]
    [string]$clientSecret,

    [Parameter(Mandatory = $true)]
    [string]$sourceCsvFilePath,

    [Parameter(Mandatory = $true)]
    [string]$outputCsvFilePath
)

$tokenUrl = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"

# Prepare the request body
$body = @{
    client_id     = $clientId
    scope         = "https://graph.microsoft.com/.default"
    client_secret = $clientSecret
    grant_type    = "client_credentials"
}

# Fetch the token
$response = Invoke-RestMethod -Method Post -Uri $tokenUrl -Body $body
$token = $response.access_token

# Read source CSV
$sourceData = Import-Csv -Path $sourceCsvFilePath

# Prepare an empty array for the output data
$outputData = @()

foreach ($row in $sourceData) {
    $userId = $row.id
    $name = $row.displayName.Replace(" | Assurances ARO", "")
    $job = $row.jobTitle
    $office = $row.department
    $department = $row.state

    $managerUrl = "https://graph.microsoft.com/v1.0/users/$userId/manager"
    
    $headers = @{
        Authorization = "Bearer $token"
    }

    $managerId = "N/A"
    try {
        $manager = Invoke-RestMethod -Method Get -Uri $managerUrl -Headers $headers
        $managerId = $manager.id
    }
    catch {
        if ($_.Exception.Response.StatusCode -ne 'NotFound') {
            Write-Output "An error occurred for user $name : $($_.Exception.Message)"
        }
    }

    # Create a custom object for the output data and add it to the output array
    $outputObj = [PSCustomObject]@{
        UserID     = $userId
        Name       = $name
        Job        = $job
        Office     = $office
        Department = $department
        ManagerID  = $managerId
    }
    $outputData += $outputObj
}

# Export the modified data to the output CSV
$outputData | Export-Csv -Path $outputCsvFilePath -NoTypeInformation
