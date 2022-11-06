<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2022 v5.8.208
	 Created on:   	8/7/2022 1:52 PM
	 Created by:   	Skylancer
	 Organization: 	
	 Filename:     	Install-GOGGames.ps1
	===========================================================================
	.DESCRIPTION
		My attempts to automate GOG Installs, VCC Installs sometimes has issues... working on that.
    I would recommend using something VCC AIO or something else after installing a bunch of games.
    Please be sure to install .NET 3.5/2.0 or run the Online Enabler. Wouldn't hurt to enable DirectPlay
    if you installing some really old games. The GOG Installers normally check and do so, but doing it
    beforehand saves a bit of time on the installers.
    Note: If an installer fails, it will attempt to re-run it again without Silent Options, again
    this is a limiatation of the of the older install wrapper that GOG used.
#>

## Get-Drivelocation
$drives = Get-PSDrive | Select-Object -Property root
foreach ($d in $drives)
{
	if ($d.root -ne $null)
	{
		$path = $d.root + "_setup\Automations"
		if (Test-Path -Path "$path")
		{
			$script:mypath = "$path"
		}
	}
}

$PrimaryDrive = "$env:SystemDrive" + "\Games2"

$GOGInstallers = Get-ChildItem -Path "$mypath\GOG" -Filter *.exe | Select-Object name, fullname
$count = $GOGInstallers.Count

Write-Host "Installing $count items..." -ForegroundColor Green

foreach ($g in $GOGInstallers)
{
	$date = Get-Date -Format hh:mm:ss
	$name = $g.name.split("_")
	
	$folder = ""
	
	foreach ($n in $name)
	{
		if (($n.Contains(".")) -or ($n.Contains("setup")) -or ($n.Equals("v")) -or ($n.Equals("a")) -or ($n.Equals("the")) -or ($n.Contains(" ")) -or ($n.Contains("(64bit)")))
		{
		}
		else
		{
			$folder = $folder + "$n"
		}
	}
	
	$installpath = "$PrimaryDrive\$folder"
	$installer = $g.fullname
	Write-Host "`n`nInstalling: $installer"
	Write-Host "Installer Path: $installpath" -ForegroundColor Yellow
	Write-Host "Start Time: $date"
	if (Test-Path -Path $installpath)
	{
		#Path is not vaild, making a vaild one.
		$getrandom = Get-Random -Maximum 999 -Minimum 100
		$installpath = "$PrimaryDrive\" + "$folder" + "$getrandom"
		$installargs = "/sp /closeapplications /surpressmsgboxes /norestart /silent /dir=`"$installpath`""
		Start-Process -FilePath "$installer" -ArgumentList "$installargs" -Wait
	}
	else
	{
		#Installing File
		$installargs = "/sp /closeapplications /surpressmsgboxes /norestart /silent /dir=`"$installpath`""
		Start-Process -FilePath "$installer" -ArgumentList "$installargs" -Wait
	}
	#Check for Install Dir, if not present, something didn't work with the installer, using alternative arguments.
	if (!(Test-Path -Path $installpath))
	{
		Write-Host "Previous Arguments didn't work, trying alternatives...`nThis method requires some interaction.`n" -ForegroundColor Red
		$installargs = "/sp /closeapplications /dir=`"$installpath`""
		Start-Process -FilePath "$installer" -ArgumentList "$installargs" -Wait
	}
	
	if (!(Test-Path -Path $installpath))
	{
		$date = Get-Date -Format hh:mm:ss
		Write-Host "Unable to install: $installer on $date" -ForegroundColor Red
	}
	else
	{
		$date = Get-Date -Format hh:mm:ss
		Write-Host "Finished: $name on $date" -ForegroundColor Green
	}
}
