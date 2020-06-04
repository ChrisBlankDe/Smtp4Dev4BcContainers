---
external help file: Smtp4Dev4BcContainers-help.xml
Module Name: Smtp4Dev4BcContainers
online version:
schema: 2.0.0
---

# New-Smtp4DevContainer

## SYNOPSIS
Creates or recreates a new container with smtp4dev

## SYNTAX

```
New-Smtp4DevContainer [[-Shortcut] <String>] [-Reset] [[-LocalUiPort] <Int32>] [[-LocalSmtpPort] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a new container based on the latest smtp4dev image

## EXAMPLES

### EXAMPLE 1
```
New-Smtp4DevContainer
```

### EXAMPLE 2
```
New-Smtp4DevContainer -Reset
```

## PARAMETERS

### -Shortcut
Removes all the Cache from your local machine before recreating a new smtp4dev container

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Desktop
Accept pipeline input: False
Accept wildcard characters: False
```

### -Reset
Removes all the Cache from your local machine before recreating a new smtp4dev container

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

### -LocalUiPort
{{ Fill LocalUiPort Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 3000
Accept pipeline input: False
Accept wildcard characters: False
```

### -LocalSmtpPort
{{ Fill LocalSmtpPort Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 2525
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

