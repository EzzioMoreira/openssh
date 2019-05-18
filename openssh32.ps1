choco install openssh -y
cd 'C:\Program Files\OpenSSH-Win32'
.\install-sshd.ps1
Start-Service sshd
Set-Service sshd -StartupType Automatic
New-NetFirewallRule -DisplayName “Allow OpenSSH” -Direction Inbound -Program "C:\Program Files\OpenSSH-Win64\sshd.exe" -RemoteAddress LocalSubnet -Action Allow –Group “OpenSSH”
