Connect-PowerBIServiceAccount -Environment "Global"
$Workspaces = @("Dev", "UAT", "Prod")
foreach ($ws in $Workspaces) {
    $Datasets = Get-PowerBIDataset -Workspace $ws
    foreach ($ds in $Datasets) {
        Invoke-PowerBIRestMethod -Url "groups/$($ds.WorkspaceId)/datasets/$($ds.Id)/refreshes" -Method POST
    }
}