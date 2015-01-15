##########################################################################
# Created on:   28/12/2014 23:07
# Created by:   Mads
#-------------------------------------------------------------------------
# Module Name:  Lightify
##########################################################################
$script:appId = 2058
$script:userId = ""
$script:securityToken = ""
$script:devId = ""
$progressPreference = 'silentlyContinue'
$script:cloudURL = "https://emea-srmprod01-api.arrayent.com:8081/zdk/services/zamapi" #EMEA Server
#$script:cloudURL = "https://na-srmprod02-api.arrayent.com:8081/zdk/services/zamapi" #North America

Function Get-deviceId
{
	BEGIN
	{
		
		$url = "$script:cloudURL/getDeviceList?secToken=$script:securityToken&userId=$script:userId"
	}
	
	PROCESS
	{
		Try
		{
			[xml]$result = Invoke-RestMethod -Method Get -Uri $url -ErrorAction Ignore
		}
		Catch
		{
			$result = $_.Exception.Response.GetResponseStream()
			$reader = New-Object System.IO.StreamReader($result)
			$reader.BaseStream.Position = 0
			$reader.DiscardBufferedData()
			[xml]$result = $reader.ReadToEnd()
		}
		[int]$NodeExists = $result.requestFault.errorCode
		If ($NodeExists)
		{
			Write-Host "Error Code: $NodeExists - " $result.requestFault.errorMsg
			$script:devId = ""
		}
		Else
		{
			$script:devId = $result.getDeviceListResponse.devList.devId
		}
	}#End Process
	
	END
	{
		Return $result
	}
}

Function Invoke-LightifyUserLogin
{
	[CmdletBinding()]
	param (
		[parameter(Position = 0, Mandatory = $true)]
		[string]$name,
		[parameter(Position = 1, Mandatory = $true)]
		[string]$password
	
	)
    BEGIN { 
    		$url = "$script:cloudURL/userLogin?name=$name&password=$password&appId=$script:appId"
    }

    PROCESS {
		Try
		{
			[xml]$result = Invoke-RestMethod -Method Get -Uri $url
			
        }
        Catch {
                $result = $_.Exception.Response.GetResponseStream()
                $reader = New-Object System.IO.StreamReader($result)
                $reader.BaseStream.Position = 0
                $reader.DiscardBufferedData()
                [xml]$result =  $reader.ReadToEnd()
        }
        [int]$NodeExists =  $result.requestFault.errorCode
        If($NodeExists){
            Write-Host "Error Code: $NodeExists - " $result.requestFault.errorMsg
            $script:userId = ""
            $script:securityToken = ""
        }
        Else{
            $script:userId = $result.userLoginResponse.userId
            $script:securityToken = $result.userLoginResponse.securityToken
        }
    }#End Process 
	
	END
	{
		Get-deviceId
		Write-Verbose "Success"
        Return $result
    }
}

function Invoke-LightifyAction{
	[CmdletBinding()]
  param(
        [parameter(Position = 0,Mandatory = $true)]
        [ValidateRange(1,50)]
        [int]$id,
        
        [parameter(parametersetname="on")]
        [switch]$on,
        [parameter(parametersetname="off")]
        [switch]$off,
        [parameter(parametersetname="toggle")]
        [switch]$toggle,
        [parameter(parametersetname="identify")]
        [switch]$identify,
        [parameter(parametersetname="leave")]
        [switch]$leave,        
        [parameter(parametersetname="connect")]
        [switch]$connect, 
        [parameter(parametersetname="cct")]
        [switch]$cct, 
        [parameter(parametersetname="colorxy")]
        [switch]$colorxy, 
        [parameter(parametersetname="rgbw")]
        [switch]$rgbw,
        [parameter(parametersetname="colorhue")]
        [switch]$colorhue,
        [parameter(parametersetname="colorloop")]
        [switch]$colorloop,
        [parameter(parametersetname="dim")]
        [switch]$dim,
        [parameter(parametersetname="blink")]
        [switch]$blink,

        [parameter(Mandatory=$false, ParameterSetName="on")]
		[parameter(Mandatory = $false, ParameterSetName = "off")]
		[parameter(Mandatory = $true, ParameterSetName = "dim")]
        [ValidateRange(6,100)]
        [int]$dimLevel,
        [parameter(Mandatory=$true, ParameterSetName="colorloop")]
        [ValidateRange(1,60)]
        [int]$loopT,
        [parameter(Mandatory=$true, ParameterSetName="cct")]
        [ValidateRange(2000,6500)]
        [int]$kelvin,
        [parameter(Mandatory=$true, ParameterSetName="rgbw")]
        [ValidateRange(0,255)]
        [int]$R,
        [parameter(Mandatory=$true, ParameterSetName="rgbw")]
        [ValidateRange(0,255)]
        [int]$G,
        [parameter(Mandatory=$true, ParameterSetName="rgbw")]
        [ValidateRange(0,255)]
        [int]$B,
        [parameter(Mandatory=$true, ParameterSetName="rgbw")]
        [ValidateRange(0,255)]
        [int]$W,
        [parameter(Mandatory=$true, ParameterSetName="colorxy")]
        [ValidateRange(0,40000)]
        [int]$X,
        [parameter(Mandatory=$true, ParameterSetName="colorxy")]
        [ValidateRange(0,40000)]
        [int]$Y,
        [parameter(Mandatory=$true, ParameterSetName="colorhue")]
        [ValidateRange(0,254)]
        [int]$hue,
        [parameter(Mandatory=$true, ParameterSetName="colorhue")]
        [ValidateRange(0,254)]
        [int]$sat
       )
    
    BEGIN { 
        $item = $PsCmdlet.ParameterSetName
        $url = $script:cloudURL + "/setDeviceAttribute?secToken=$script:securityToken&devId=$script:devId&name=DeviceAction&value=device$id"
    }


	PROCESS {
		Switch ($item)
		{ 
            "on"        { $url += ",$item" + (&{If($dimLevel) {",$dimLevel"}}) }
            "off"       { $url += ",$item" + (&{If($dimLevel) {",$dimLevel"}}) }
            "toggle"    { $url += ",$item"}
            "identify"  { $url += ",$item"} 
            "leave"     { }        
            "connect"   { } 
            "cct"       { $url += ",$item,$kelvin,00" } 
            "colorxy"   { $url += ",$item,$X,$Y" }
            "rgbw"      { $url += ",$item,$R,$G,$B,$W,00" } 
            "colorhue"  { $url += ",$item,$hue,$sat" }
            "colorloop" { $url += ",$item,$loopT" }
            "dim"       { $url += ",on" + (&{If($dimLevel) {",$dimLevel"}}) }
            "blink"     { $url += ",off,50"}
        }
		
        Try {
                [xml]$result= Invoke-RestMethod -Method Get -Uri $url -ErrorAction Ignore
        }
        Catch {
                $result = $_.Exception.Response.GetResponseStream()
                $reader = New-Object System.IO.StreamReader($result)
                $reader.BaseStream.Position = 0
                $reader.DiscardBufferedData()
                [xml]$result =  $reader.ReadToEnd()
        }
        [int]$Empty =  $result.requestFault.errorCode
        If($Empty){
            Write-Host "Error Code: $Empty - " $result.requestFault.errorMsg
        }
        else{
			Write-Verbose "Success"
        }
    }#End Process
    END { }
}


Export-ModuleMember Invoke-LightifyUserLogin
Export-ModuleMember Invoke-LightifyAction