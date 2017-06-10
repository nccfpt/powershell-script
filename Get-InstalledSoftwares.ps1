# Get-Installedsoftwares.ps1
# Created by Nguyen Tuan
# Website:  www.blogthuthuatwin10.com


If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $args" -Verb RunAs
	Exit
}

Function Main-menu()
{
	$index=1
    	$items = @(
        	"HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
        	"HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    	)
	$softwares=Get-ItemProperty $items
	#return entire listing of softwares 
	    	Write-Host "ID`t Installed software"
        	echo ""
	foreach ($software in $softwares)
	{
		Write-Host " $index`t $($software.displayname)"
        	$index++
    	}
    	if ($softwares)
    	{
		$index++
        	echo ""
        	pause
	}
    	else
    	{
        	Write-Host "Software not found"
        	echo ""
        	pause
    }
}
Main-menu
