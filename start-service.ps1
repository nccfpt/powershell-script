# Start-Service
# Created by Nguyen Tuan
# Fb.com\kequaduongvodanh

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $args" -Verb RunAs
	Exit
}
	$index=1
	$Services=Get-Service | Where-Object {$_.Status -eq "Stopped"}
	#return entire listing of applications 
	    	Write-Host "ID`t Service Name"
    		""
	foreach ($Service in $Services)
	{
		Write-Host " $index`t $($Service.DisplayName)"
		$index++
	}
    	Do
    	{
        	""
        	$IDs=Read-Host -Prompt "For start the service please select ID and press enter"
    	}
    	While($IDs -eq "")
	#check whether input values are correct
	try
	{	
		[int[]]$IDs=$IDs -split ","
	}
	catch
	{
		 StatusText "`n$($_.Exception.Message)" 
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
		}
		else
		{
			""
            		Write-warning -Message "wrong ID"
        	}
    	}
    Pause
