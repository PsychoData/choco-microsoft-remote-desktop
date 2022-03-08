$packageName = 'microsoft-remote-desktop'
$64_bitInstaller = 'https://go.microsoft.com/fwlink/?linkid=2068602'

Push-Location $PSScriptRoot

#Check latest version by
$result = Invoke-WebRequest $64_bitInstaller -Method Head
$TargetVersion = $result.Headers.'Content-Disposition' -replace "^.*RemoteDesktop_(.*)_(x86|x64).msi",'$1'
choco pack .\microsoft-remote-desktop\microsoft-remote-desktop.nuspec --version $TargetVersion --outputdirectory .\output\ 

$packedInstaller = Get-Item .\Output\$($packageName + "." + $TargetVersion).nupkg
choco push $packedInstaller.FullName --source https://push.chocolatey.org/

Pop-location