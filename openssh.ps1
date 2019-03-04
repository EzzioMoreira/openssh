choco install openssh -y
cd 'C:\Program Files\OpenSSH-Win64'
.\install-sshd.ps1
New-NetFirewallRule -DisplayName "OpenSSH Server (sshd)" -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
Start-Service sshd
Set-Service sshd -StartupType Automatic
