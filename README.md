Smtp4Dev4BcContainers is a PowerShell module allowes you to easily create a [smtp4dev](https://github.com/rnwood/smtp4dev) container and set the required configurations in you Business Central containers
# Prerequisites
You must have installed [navcontianerhelper](https://github.com/microsoft/navcontainerhelper) and administrative rights on the machine you running this module.

# How to use
Install the Module
````powershell
Install-Module -Name Smtp4Dev4BcContainers
````
Create smtp4dev Container
````powershell
New-Smtp4DevContainer
````
Test smtp4dev Container
````powershell
Test-Smtp4DevContainer
````
Set Configuration in your Business Central container
````powershell
Set-Smtp4DevInBcContainer -containerName navserver
````