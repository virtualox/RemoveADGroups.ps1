# Active Directory Group Remover (PowerShell)

This PowerShell script automates the process of checking and removing Active Directory groups as per the input provided in a text file.

## Description

The script reads a list of Active Directory group names from a text file, checks if each group exists, and if it does, removes it. It then stores the result (either successful removal or error message) into the clipboard, formatted for easy pasting into a helpdesk ticket system.

## Getting Started

### Dependencies

* You need to have the Active Directory module for Windows PowerShell installed and loaded on your system.

### Executing program

* Replace `"FilePath"` with the actual path to your text file.
* Run the script with administrative privileges sufficient to remove groups from Active Directory.

```powershell
.\RemoveADGroups.ps1 -FilePath "C:\path\to\your\file.txt"
```

## Help

Be sure to run this script with sufficient administrative privileges to remove groups from Active Directory. Removing the wrong groups can have serious consequences. Only use this script if you're sure that you're removing the correct groups.
