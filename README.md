![Release](https://github.com/ChrisBlankDe/Smtp4Dev4BcContainers/workflows/Release/badge.svg) [![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/Smtp4Dev4BcContainers)](https://www.powershellgallery.com/packages/Smtp4Dev4BcContainers)

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
Set Configuration in your Business Central container
````powershell
Set-Smtp4DevInBcContainer -containerName navserver
````
Now you can open smtp4dev on port 3000: http://localhost:3000

# Knowen Issues ans planned improvements
* When smtp4dev container gets a new IP address ````Set-Smtp4DevInBcContainer```` must be executed.
* Currently smtp4dev can only be addressed throu ip. Implement something like ````updateHosts```` from navcontainerhelper later.
* Create a shortcut on desktop or startmenu
