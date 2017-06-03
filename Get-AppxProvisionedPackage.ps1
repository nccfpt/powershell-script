# Remove-AppxProvisionedPackage
# Created by Nguyen Tuan
# Website:  www.blogthuthuatwin10.com
# Github:   github.com/blogthuthuatwin10
# Facebook: facebook.com/blogthuthuatwin10
# Twitter:  twitter.com/thuthuatwin10
# Google+:  plus.google.com/+blogthuthuatwin10
# Youtube:  youtube.com/blogthuthuatwin10

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $args" -Verb RunAs
	Exit
}

Function Main-menu()
{
	$index=1
	$apps=Get-AppxProvisionedPackage -online
	#return entire listing of applications 
	    	Write-Host "ID`t App name"
        	Write-Host ""
	foreach ($app in $apps)
	{
		Write-Host " $index`t $($app.DisplayName)"
        $index++
    	}
    	if ($apps)
    	{
		$index++
        	Write-Host ""
        	pause
	}
    	else
    	{
        	Write-Host "Apps not found"
        	Write-Host ""
        	pause
    	}
}
Main-menu
