# Ezzio Moreira
# enzziom@gmail.com
# Installing OpenSSH with PowerShell

# To install OpenSSH using PowerShell, first launch PowerShell as an Administrator and set script execution in windows policy

Set-ExcutionPolicy Unrestricted
 
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrador"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'

# This should return the following output:
# Install the OpenSSH Client

Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Install the OpenSSH Server

Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Both of these should return the following output:
# Initial Configuration of SSH Server
# To configure the OpenSSH server for initial use on Windows, launch PowerShell as an administrator, then run the following commands to start the SSHD service:

Start-Service sshd

# OPTIONAL but recommended:

Set-Service -Name sshd -StartupType 'Automatic'

# Confirm the Firewall rule is configured. It should be created automatically by setup. 

Get-NetFirewallRule -Name *ssh*

# There should be a firewall rule named "OpenSSH-Server-In-TCP", which should be enabled
# If the firewall does not exist, create one

New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
