
#----------------------------------------------
#region Application Functions
#----------------------------------------------

function OnApplicationLoad {
	Import-Module .\Lightify
	$progressPreference = 'silentlyContinue'
	return $true 
}

#endregion Application Functions

#----------------------------------------------
# Generated Form Function
#----------------------------------------------
function Call-Lightify_Test_psf {

	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Xml, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.DirectoryServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Core, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.ServiceProcess, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$formOsramLightifyTest = New-Object 'System.Windows.Forms.Form'
	$t_dimLevel = New-Object 'System.Windows.Forms.TextBox'
	$labelDimLevel = New-Object 'System.Windows.Forms.Label'
	$cb_DeviceID = New-Object 'System.Windows.Forms.ComboBox'
	$b_GetC = New-Object 'System.Windows.Forms.Button'
	$labelDeviceID = New-Object 'System.Windows.Forms.Label'
	$t_password = New-Object 'System.Windows.Forms.TextBox'
	$labelAction = New-Object 'System.Windows.Forms.Label'
	$t_loopT = New-Object 'System.Windows.Forms.TextBox'
	$t_Hue = New-Object 'System.Windows.Forms.TextBox'
	$t_Sat = New-Object 'System.Windows.Forms.TextBox'
	$labelLoopTime = New-Object 'System.Windows.Forms.Label'
	$labelHueSat = New-Object 'System.Windows.Forms.Label'
	$t_Kelvin = New-Object 'System.Windows.Forms.TextBox'
	$t_X = New-Object 'System.Windows.Forms.TextBox'
	$t_Y = New-Object 'System.Windows.Forms.TextBox'
	$labelXY = New-Object 'System.Windows.Forms.Label'
	$labelKelvin = New-Object 'System.Windows.Forms.Label'
	$t_W = New-Object 'System.Windows.Forms.TextBox'
	$t_R = New-Object 'System.Windows.Forms.TextBox'
	$labelRGBW = New-Object 'System.Windows.Forms.Label'
	$t_G = New-Object 'System.Windows.Forms.TextBox'
	$t_B = New-Object 'System.Windows.Forms.TextBox'
	$labelEnterYourLightifyCre = New-Object 'System.Windows.Forms.Label'
	$t_username = New-Object 'System.Windows.Forms.TextBox'
	$labelPassword = New-Object 'System.Windows.Forms.Label'
	$labelUsername = New-Object 'System.Windows.Forms.Label'
	$cb_action = New-Object 'System.Windows.Forms.ComboBox'
	$b_UserLogin = New-Object 'System.Windows.Forms.Button'
	$b_InvokeAction = New-Object 'System.Windows.Forms.Button'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	function OnApplicationLoad {
		Import-Module .\Lightify
		$progressPreference = 'silentlyContinue'
		return $true 
	}
	
	$FormEvent_Load = {
		#Fill Combos
		$cb_action.items.Add("on")
		$cb_action.items.Add("off")
		$cb_action.items.Add("toggle")
		$cb_action.items.Add("identify")
		$cb_action.items.Add("cct")
		$cb_action.items.Add("colorxy")
		$cb_action.items.Add("rgbw")
		$cb_action.items.Add("colorhue")
		$cb_action.items.Add("colorloop")
		$cb_action.items.Add("dim")
		$cb_action.items.Add("blink")
		1..50 | % { $cb_DeviceID.Items.Add(($_)) }
		$cb_action.SelectedIndex = 0
		$cb_DeviceID.SelectedIndex = 0
		
		#Defaults
		$t_R.text = 255
		$t_G.text = 0
		$t_B.text = 0
		$t_X.text = 0
		$t_W.text = 0
		$t_Y.text = 0
		$t_Hue.text = 0
		$t_Sat.text = 0
		$t_loopT.text = 12
		$t_Kelvin.text = 2000
		$t_dimLevel.text = 30
		$t_hue.text = 10
		$t_sat.text = 240
	}
	
	$b_UserLogin_Click = {
		Invoke-LightifyUserLogin -name $t_username.text -password $t_password.text 
	}
	
	$b_InvokeAction_Click={
		Switch ($cb_action.SelectedItem)
		{
			"on" { Invoke-LightifyAction -id $cb_DeviceID.Text -on }
			"off" { Invoke-LightifyAction -id $cb_DeviceID.Text -off}
			"toggle" { Invoke-LightifyAction -id $cb_DeviceID.Text -toggle }
			"identify" { Invoke-LightifyAction -id $cb_DeviceID.Text -identify }
			"cct" { Invoke-LightifyAction -id $cb_DeviceID.Text -cct -kelvin $t_Kelvin.text }
			"colorxy" { Invoke-LightifyAction -id $cb_DeviceID.Text -colorxy -X $t_X.text -Y $t_Y.text}
			"rgbw" { Invoke-LightifyAction -id $cb_DeviceID.Text -rgbw -R $t_R.text -G $t_G.text -B $t_B.text -W $t_W.text}
			"colorhue" { Invoke-LightifyAction -id $cb_DeviceID.Text -colorhue -hue $t_hue.text -sat $t_sat.text}
			"colorloop" { Invoke-LightifyAction -id $cb_DeviceID.Text -colorloop -loopT $t_loopT.text}
			"dim" { Invoke-LightifyAction -id $cb_DeviceID.Text  -dim -dimlevel $t_dimLevel.Text}
			"blink" { Invoke-LightifyAction -id $cb_DeviceID.Text -blink }
		}
	}
	
	$b_GetC_Click={
		$colorDialog = New-Object Windows.Forms.ColorDialog -Property @{ FullOpen = $true; Color = [Drawing.Color]::FromArgb($t_R.text, $t_G.text, $t_B.text) }
		if ($colorDialog.ShowDialog() -eq "OK")
		{
			$t_R.text = $colordialog.color.R
			$t_G.text = $colordialog.color.G
			$t_B.text = $colordialog.color.B
		}
	}
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$formOsramLightifyTest.WindowState = $InitialFormWindowState
	}
	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$b_GetC.remove_Click($b_GetC_Click)
			$b_UserLogin.remove_Click($b_UserLogin_Click)
			$b_InvokeAction.remove_Click($b_InvokeAction_Click)
			$formOsramLightifyTest.remove_Load($FormEvent_Load)
			$formOsramLightifyTest.remove_Load($Form_StateCorrection_Load)
			$formOsramLightifyTest.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch [Exception]
		{ }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$formOsramLightifyTest.SuspendLayout()
	#
	# formOsramLightifyTest
	#
	$formOsramLightifyTest.Controls.Add($t_dimLevel)
	$formOsramLightifyTest.Controls.Add($labelDimLevel)
	$formOsramLightifyTest.Controls.Add($cb_DeviceID)
	$formOsramLightifyTest.Controls.Add($b_GetC)
	$formOsramLightifyTest.Controls.Add($labelDeviceID)
	$formOsramLightifyTest.Controls.Add($t_password)
	$formOsramLightifyTest.Controls.Add($labelAction)
	$formOsramLightifyTest.Controls.Add($t_loopT)
	$formOsramLightifyTest.Controls.Add($t_Hue)
	$formOsramLightifyTest.Controls.Add($t_Sat)
	$formOsramLightifyTest.Controls.Add($labelLoopTime)
	$formOsramLightifyTest.Controls.Add($labelHueSat)
	$formOsramLightifyTest.Controls.Add($t_Kelvin)
	$formOsramLightifyTest.Controls.Add($t_X)
	$formOsramLightifyTest.Controls.Add($t_Y)
	$formOsramLightifyTest.Controls.Add($labelXY)
	$formOsramLightifyTest.Controls.Add($labelKelvin)
	$formOsramLightifyTest.Controls.Add($t_W)
	$formOsramLightifyTest.Controls.Add($t_R)
	$formOsramLightifyTest.Controls.Add($labelRGBW)
	$formOsramLightifyTest.Controls.Add($t_G)
	$formOsramLightifyTest.Controls.Add($t_B)
	$formOsramLightifyTest.Controls.Add($labelEnterYourLightifyCre)
	$formOsramLightifyTest.Controls.Add($t_username)
	$formOsramLightifyTest.Controls.Add($labelPassword)
	$formOsramLightifyTest.Controls.Add($labelUsername)
	$formOsramLightifyTest.Controls.Add($cb_action)
	$formOsramLightifyTest.Controls.Add($b_UserLogin)
	$formOsramLightifyTest.Controls.Add($b_InvokeAction)
	$formOsramLightifyTest.ClientSize = '234, 352'
	$formOsramLightifyTest.FormBorderStyle = 'FixedDialog'
	$formOsramLightifyTest.MaximizeBox = $False
	$formOsramLightifyTest.MinimizeBox = $False
	$formOsramLightifyTest.Name = "formOsramLightifyTest"
	$formOsramLightifyTest.StartPosition = 'CenterScreen'
	$formOsramLightifyTest.Text = "Osram Lightify Test"
	$formOsramLightifyTest.add_Load($FormEvent_Load)
	#
	# t_dimLevel
	#
	$t_dimLevel.Location = '74, 242'
	$t_dimLevel.Name = "t_dimLevel"
	$t_dimLevel.Size = '29, 20'
	$t_dimLevel.TabIndex = 15
	#
	# labelDimLevel
	#
	$labelDimLevel.Location = '16, 245'
	$labelDimLevel.Name = "labelDimLevel"
	$labelDimLevel.Size = '52, 23'
	$labelDimLevel.TabIndex = 46
	$labelDimLevel.Text = "DimLevel"
	$labelDimLevel.TextAlign = 'TopRight'
	#
	# cb_DeviceID
	#
	$cb_DeviceID.FormattingEnabled = $True
	$cb_DeviceID.Location = '75, 267'
	$cb_DeviceID.Name = "cb_DeviceID"
	$cb_DeviceID.Size = '133, 21'
	$cb_DeviceID.TabIndex = 16
	#
	# b_GetC
	#
	$b_GetC.Location = '144, 135'
	$b_GetC.Name = "b_GetC"
	$b_GetC.Size = '64, 23'
	$b_GetC.TabIndex = 10
	$b_GetC.Text = "Pick RGB"
	$b_GetC.UseVisualStyleBackColor = $True
	$b_GetC.add_Click($b_GetC_Click)
	#
	# labelDeviceID
	#
	$labelDeviceID.Location = '7, 271'
	$labelDeviceID.Name = "labelDeviceID"
	$labelDeviceID.Size = '61, 23'
	$labelDeviceID.TabIndex = 43
	$labelDeviceID.Text = "DeviceID:"
	$labelDeviceID.TextAlign = 'TopRight'
	#
	# t_password
	#
	$t_password.Location = '74, 57'
	$t_password.Name = "t_password"
	$t_password.PasswordChar = '*'
	$t_password.Size = '134, 20'
	$t_password.TabIndex = 2
	#
	# labelAction
	#
	$labelAction.Location = '6, 296'
	$labelAction.Name = "labelAction"
	$labelAction.Size = '62, 23'
	$labelAction.TabIndex = 39
	$labelAction.Text = "Action"
	$labelAction.TextAlign = 'TopRight'
	#
	# t_loopT
	#
	$t_loopT.Location = '74, 190'
	$t_loopT.Name = "t_loopT"
	$t_loopT.Size = '29, 20'
	$t_loopT.TabIndex = 13
	#
	# t_Hue
	#
	$t_Hue.Location = '74, 164'
	$t_Hue.Name = "t_Hue"
	$t_Hue.Size = '29, 20'
	$t_Hue.TabIndex = 11
	#
	# t_Sat
	#
	$t_Sat.Location = '109, 164'
	$t_Sat.Name = "t_Sat"
	$t_Sat.Size = '29, 20'
	$t_Sat.TabIndex = 12
	#
	# labelLoopTime
	#
	$labelLoopTime.Location = '6, 193'
	$labelLoopTime.Name = "labelLoopTime"
	$labelLoopTime.Size = '62, 25'
	$labelLoopTime.TabIndex = 35
	$labelLoopTime.Text = "LoopTime"
	$labelLoopTime.TextAlign = 'TopRight'
	#
	# labelHueSat
	#
	$labelHueSat.Location = '16, 167'
	$labelHueSat.Name = "labelHueSat"
	$labelHueSat.Size = '52, 23'
	$labelHueSat.TabIndex = 33
	$labelHueSat.Text = "Hue/Sat"
	$labelHueSat.TextAlign = 'TopRight'
	#
	# t_Kelvin
	#
	$t_Kelvin.Location = '74, 216'
	$t_Kelvin.Name = "t_Kelvin"
	$t_Kelvin.Size = '64, 20'
	$t_Kelvin.TabIndex = 14
	#
	# t_X
	#
	$t_X.Location = '74, 138'
	$t_X.Name = "t_X"
	$t_X.Size = '29, 20'
	$t_X.TabIndex = 8
	#
	# t_Y
	#
	$t_Y.Location = '109, 138'
	$t_Y.Name = "t_Y"
	$t_Y.Size = '29, 20'
	$t_Y.TabIndex = 9
	#
	# labelXY
	#
	$labelXY.Location = '16, 138'
	$labelXY.Name = "labelXY"
	$labelXY.Size = '52, 25'
	$labelXY.TabIndex = 29
	$labelXY.Text = "X, Y"
	$labelXY.TextAlign = 'TopRight'
	#
	# labelKelvin
	#
	$labelKelvin.Location = '16, 219'
	$labelKelvin.Name = "labelKelvin"
	$labelKelvin.Size = '52, 23'
	$labelKelvin.TabIndex = 28
	$labelKelvin.Text = "Kelvin"
	$labelKelvin.TextAlign = 'TopRight'
	#
	# t_W
	#
	$t_W.Location = '179, 112'
	$t_W.Name = "t_W"
	$t_W.Size = '29, 20'
	$t_W.TabIndex = 7
	#
	# t_R
	#
	$t_R.Location = '74, 112'
	$t_R.Name = "t_R"
	$t_R.Size = '29, 20'
	$t_R.TabIndex = 4
	#
	# labelRGBW
	#
	$labelRGBW.Location = '6, 115'
	$labelRGBW.Name = "labelRGBW"
	$labelRGBW.Size = '62, 23'
	$labelRGBW.TabIndex = 25
	$labelRGBW.Text = "R, G, B, W"
	$labelRGBW.TextAlign = 'TopRight'
	#
	# t_G
	#
	$t_G.Location = '109, 112'
	$t_G.Name = "t_G"
	$t_G.Size = '29, 20'
	$t_G.TabIndex = 5
	#
	# t_B
	#
	$t_B.Location = '144, 112'
	$t_B.Name = "t_B"
	$t_B.Size = '29, 20'
	$t_B.TabIndex = 6
	#
	# labelEnterYourLightifyCre
	#
	$labelEnterYourLightifyCre.Location = '16, 11'
	$labelEnterYourLightifyCre.Name = "labelEnterYourLightifyCre"
	$labelEnterYourLightifyCre.Size = '158, 23'
	$labelEnterYourLightifyCre.TabIndex = 19
	$labelEnterYourLightifyCre.Text = "Enter your Lightify credentials"
	#
	# t_username
	#
	$t_username.Location = '74, 34'
	$t_username.Name = "t_username"
	$t_username.Size = '134, 20'
	$t_username.TabIndex = 1
	#
	# labelPassword
	#
	$labelPassword.Location = '16, 57'
	$labelPassword.Name = "labelPassword"
	$labelPassword.Size = '65, 23'
	$labelPassword.TabIndex = 18
	$labelPassword.Text = "Password:"
	#
	# labelUsername
	#
	$labelUsername.Location = '15, 34'
	$labelUsername.Name = "labelUsername"
	$labelUsername.Size = '65, 23'
	$labelUsername.TabIndex = 17
	$labelUsername.Text = "User name:"
	#
	# cb_action
	#
	$cb_action.FormattingEnabled = $True
	$cb_action.Location = '74, 293'
	$cb_action.Name = "cb_action"
	$cb_action.Size = '134, 21'
	$cb_action.TabIndex = 17
	#
	# b_UserLogin
	#
	$b_UserLogin.Location = '74, 83'
	$b_UserLogin.Name = "b_UserLogin"
	$b_UserLogin.Size = '134, 23'
	$b_UserLogin.TabIndex = 3
	$b_UserLogin.Text = "Invoke-UserLogin"
	$b_UserLogin.UseVisualStyleBackColor = $True
	$b_UserLogin.add_Click($b_UserLogin_Click)
	#
	# b_InvokeAction
	#
	$b_InvokeAction.Location = '74, 321'
	$b_InvokeAction.Name = "b_InvokeAction"
	$b_InvokeAction.Size = '134, 23'
	$b_InvokeAction.TabIndex = 18
	$b_InvokeAction.Text = "Invoke-Action"
	$b_InvokeAction.UseVisualStyleBackColor = $True
	$b_InvokeAction.add_Click($b_InvokeAction_Click)
	$formOsramLightifyTest.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $formOsramLightifyTest.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$formOsramLightifyTest.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$formOsramLightifyTest.add_FormClosed($Form_Cleanup_FormClosed)
	#Show the Form
	return $formOsramLightifyTest.ShowDialog()

} #End Function

#Call OnApplicationLoad to initialize
if((OnApplicationLoad) -eq $true)
{
	#Call the form
	Call-Lightify_Test_psf | Out-Null
}
