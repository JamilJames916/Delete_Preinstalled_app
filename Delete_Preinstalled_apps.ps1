# Define an array of apps to be removed. Adjust this list based on your needs.
$apps = @(
    "Microsoft.BingWeather",
    "Microsoft.BingNews",
    "Microsoft.Office.OneNote",
    "Microsoft.XboxGameCallableUI",
    "Microsoft.XboxIdentityProvider",
    "Microsoft.XboxGamingOVerlay",
    "Microsoft.XboxSpeechToTextOVerlay",
    "Microsoft.Xbox.TCUI",
    "Microsoft.UI.Xaml.CBS",
    "Microsoft.WindowsAppRuntime.CBS",
    "Windows.CBSPreview",
    "Microsoft.ZuneMusic",
    "Microsoft.ZuneVideo",
    "McAfeeWPSSparsePAckage",
    "E046963F.AIMeetingManager",
    "E046963F.LenovoCompanion",
    "E0469640.SmartAppearance",
    "DolbyLaboratories.DolbyAccess",
    "Clipchamp.Clipchamp",
    "Microsoft.GamingApp",
    "SpotifyAB.SpotifyMusic"
)

# Loop through each app in the array to remove it
foreach ($app in $apps) {
    Write-Output "Attempting to remove $app..."
    
    # Remove the app from all users' accounts
    $packages = Get-AppxPackage -Name $app -AllUsers
    if ($packages) {
        $packages | Remove-AppxPackage
        Write-Output "$app removed successfully."
    } else {
        Write-Output "$app not found or already removed."
    }

    # Attempt to remove the provisioning package to prevent future installations
    $provisioned = Get-AppxProvisionedPackage -Online | Where-Object DisplayName -EQ $app
    if ($provisioned) {
        Remove-AppxProvisionedPackage -Online -PackageName $provisioned.PackageName
        Write-Output "$app de-provisioned successfully."
    } else {
        Write-Output "$app provisioning not found or already de-provisioned."
    }
}

Write-Output "Script completed. All specified apps have been processed."

