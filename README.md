"# phishtank-vm" 

#steps:

Create a new VM (current configurations are ) 8GB with 2 CPUS
Install git

For running powershell commands from gocd, the following commands may be needed:
Run with admin priviledges:
```
Set-ExecutionPolicy "RemoteSigned" -Scope Process -Confirm:$false
Set-ExecutionPolicy "RemoteSigned" -Scope CurrentUser -Confirm:$false
set-executionpolicy remotesigned -force
```