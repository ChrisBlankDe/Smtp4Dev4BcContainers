---
external help file: Smtp4Dev4BcContainers-help.xml
Module Name: Smtp4Dev4BcContainers
online version:
schema: 2.0.0
---

# Set-Smtp4DevInBcContainer

## SYNOPSIS
Sets the smtp4dev connection data in the given container

## SYNTAX

```
Set-Smtp4DevInBcContainer [[-ContainerName] <String>] [-Force] [<CommonParameters>]
```

## DESCRIPTION
Gets the smtp configuration from your smtp4dev container and inserts it into all tenants and all companies whithin the given container

## EXAMPLES

### EXAMPLE 1
```
Set-Smtp4DevInBcContainer
```

### EXAMPLE 2
```
Set-Smtp4DevInBcContainer -ContainerName 'AnyBcContainer'
```

## PARAMETERS

### -ContainerName
Name of the container where you want to configure the smtp mail setup.
Default is 'navserver'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Navserver
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Force
Avoid asking if Server Instances should be restarted, just do it.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

