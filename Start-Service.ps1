# Start-Service
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
	$Services=Get-Service | Where-Object {$_.Status -eq "Stopped"}
	#return entire listing of applications 
	    	Write-Host "ID`t Service Name"
    		Write-Host ""
	foreach ($Service in $Services)
	{
		Write-Host " $index`t $($Service.DisplayName)"
		$index++
	}
    	Do
    	{
        	Write-Host ""
        	$IDs=Read-Host -Prompt "For start each service please select ID and press enter"
    	}
    	While($IDs -eq "")
	#check whether input values are correct
	try
	{	
		[int[]]$IDs=$IDs -split ","
	}
	catch
	{
		 Write-Host "Error:" $_.Exception.Message 
	}
	foreach ($ID in $IDs)
	{
		#check id is in the range
		if ($ID -ge 1 -and $ID -le $Services.count)
		{
			$ID--
			#Disable each service
			$ServiceName=$Services[$ID].Name

			Get-WMIObject win32_service | Where-Object {$_.Name -eq "$ServiceName"}
            		Set-Service $ServiceName -StartupType automatic
            		Start-Service $ServiceName
            		pause
            		cls
            		Main-menu
		}
		else
		{
			Write-Host ""
            		Write-warning -Message "wrong ID"
            		Write-Host ""
            		pause
            		cls
            		Main-menu
        	}
    	}
}
Main-menu
