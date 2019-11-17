# openssh
Installing OpenSSH from the Settings UI on Windows Server 2019 or Windows 10 1809
OpenSSH client and server are installable features of Windows 7, 10.

The prerequisite for installing openssh: (powershell 5.0) for upgrade follows the Powershell upgrade link.

1. Click Start, click All Programs, click Accessories, click Windows PowerShell, and then click Windows PowerShell.
2. In the console window, type the following command and then press ENTER.
Get-Host | Select-Object Version
3. Information similar to the following should then be displayed in the console window:

#####################
#####  Version   ####
#####  -------   ####
#####   4.0 .    ####
#####################

If the returned Version number is 5.1, then you are running Windows PowerShell 5.1. If the returned Version number is not 5.1, then you'll need to install Windows PowerShell 5.1. You can download Windows Management Framework 5.1, which includes Windows PowerShell 5.1, from the [Microsoft Download Center](https://www.microsoft.com/en-us/download/details.aspx?id=54616).

To install OpenSSH, start Settings then go to Apps > Apps and Features > Manage Optional Features.

Scan this list to see if OpenSSH client is already installed. If not, then at the top of the page select "Add a feature", then:

To install the OpenSSH client, locate "OpenSSH Client", then click "Install".
To install the OpenSSH server, locate "OpenSSH Server", then click "Install".
Once the installation completes, return to Apps > Apps and Features > Manage Optional Features and you should see the OpenSSH component(s) listed.

 Observação

Installing OpenSSH Server will create and enable a firewall rule named "OpenSSH-Server-In-TCP". This allows inbound SSH traffic on port 22.
