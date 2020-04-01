# 0. Install chocolatey.
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# 1. Install ssh (requirements powershell 5.0 and chocolatey):
choco install powershell openssh -y

# 2. Install service:
cd "C:\Program Files\OpenSSH-Win64\"
.\install-sshd.ps1

# 3. Set service startup
Set-Service sshd -StartupType Automatic -Verbose
Start-Service sshd -Verbose

# 4. Set firewall permissions:
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22 -Verbose

# 5. Set config authentication with public key
((Get-Content -path C:\ProgramData\ssh\sshd_config -Raw) `
-replace '#PubkeyAuthentication yes','PubkeyAuthentication yes' `
-replace '#PasswordAuthentication yes','PasswordAuthentication no' `
-replace 'Match Group administrators','#Match Group administrators' `
-replace '#StrictModes yes','StrictModes no' `
-replace 'AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys','#AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys') | Set-Content -Path C:\ProgramData\ssh\sshd_config

# 6. Restart service sshd
Restart-Service sshd

# 7. Create directory
$path = "$env:USERPROFILE/.ssh"
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
}

# 8. Copy key-rsa.pub from ~\.ssh\authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQC0t0Y5qDs0Z3roWT6hfgzI+awWVYi+5Wu0XIXCawD2XFJz87MLS3Etg63TW5hG0j8FJq0uD2kMNrejJFF4P1o+z4I+ynIgvSth6VnevK1wXiAb3POq4t9Kc9IZwev3HHNfJgVSD4fJqKnu3CSNySrFbvyIkFUWeLK3H9lmqCOR0w== ubuntu@ec2-54-174-28-152.compute-1.amazonaws.com" | Out-File ~\.ssh\authorized_keys -Encoding ascii

# 9. Powershell cmdlets to set powershell bash as default shell
 New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
 New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShellCommandOption -Value "/c" -PropertyType String -Force
