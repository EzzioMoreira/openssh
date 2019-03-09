choco install openssh -y
cd 'C:\Program Files\OpenSSH-Win32'
.\install-sshd.ps1
Start-Service sshd
Set-Service sshd -StartupType Automatic
