# openssh
Installing OpenSSH from the Settings UI on Windows Server 2019 or Windows 10 1809
OpenSSH client and server are installable features of Windows 10 1809.

To install OpenSSH, start Settings then go to Apps > Apps and Features > Manage Optional Features.

Scan this list to see if OpenSSH client is already installed. If not, then at the top of the page select "Add a feature", then:

To install the OpenSSH client, locate "OpenSSH Client", then click "Install".
To install the OpenSSH server, locate "OpenSSH Server", then click "Install".
Once the installation completes, return to Apps > Apps and Features > Manage Optional Features and you should see the OpenSSH component(s) listed.

 Observação

Installing OpenSSH Server will create and enable a firewall rule named "OpenSSH-Server-In-TCP". This allows inbound SSH traffic on port 22.
