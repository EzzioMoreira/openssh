# 1. Install ssh (requirements powershell 5.0 and chocolatey):
choco install powershell openssh -y

# 2. Install service:
.\'Program Files\OpenSSH-Win64\install-sshd.ps1' 

# 3. Set firewall permissions:
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22

# 4. Set service startup
Set-Service sshd -StartupType Automatic
Start-Service sshd

# 5. Set config authentication with public key
((Get-Content -path C:\ProgramData\ssh\sshd_config -Raw) `
-replace '#PubkeyAuthentication yes','PubkeyAuthentication yes' `
-replace '#PasswordAuthentication yes','PasswordAuthentication no' `
-replace 'Match Group administrators','#Match Group administrators' `
-replace 'AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys','#AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys') | Set-Content -Path C:\ProgramData\ssh\sshd_config

# 6. Restart service sshd
Restart-Service sshd

# 7. Create directory
mkdir ~/.ssh/

# 8. Copy key-rsa.pub from ~\.ssh\authorized_keys
echo "ssh-rsa xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx chiquinho@powerpc" | Out-File ~\.ssh\authorized_keys -Encoding ascii
