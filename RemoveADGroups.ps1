<#
.SYNOPSIS
   This script reads a list of Active Directory group names from a text file, checks if the group exists, removes them, and stores the result to the clipboard.

.DESCRIPTION
   This script is designed to automate the process of checking and removing Active Directory groups as per the input provided in a text file. It provides a formatted output which can be easily pasted into a helpdesk ticket system. 

.PARAMETER FilePath
   Path to the text file containing the names of the Active Directory groups.

.EXAMPLE
   PS C:\> .\RemoveADGroups.ps1 -FilePath "C:\path\to\your\file.txt"

.INPUTS
   System.String. You can pipe a string that contains a path to this script.

.OUTPUTS
   System.String. This script returns strings and places them into the clipboard.

.NOTES
   Be sure to run this script with sufficient administrative privileges to remove groups from Active Directory.
   Removing the wrong groups can have serious consequences.
   Only use this script if you're sure that you're removing the correct groups.
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$FilePath
)

# import the Active Directory module
Import-Module ActiveDirectory

# initialize an output variable
$output = @()

# read the file
$groupNames = Get-Content -Path $FilePath

foreach($groupName in $groupNames)
{
    # Remove tabs and other unwanted characters
    $groupName = $groupName -replace '\t', '' -replace '\r', '' -replace '\n', ''

    # try to find the group and remove it
    try
    {
        $group = Get-ADGroup -Identity $groupName -ErrorAction Stop

        if($group)
        {
            Remove-ADGroup -Identity $groupName -Confirm:$false
            $output += "Group '$groupName' was successfully removed."
        }
        else
        {
            $output += "Group '$groupName' was not found."
        }
    }
    catch
    {
        if($_.Exception -is [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException])
        {
            $output += "Group '$groupName' was not found."
        }
        else
        {
            $output += "An error occurred while trying to remove the group '$groupName'. Error: $($_.Exception.Message)"
        }
    }
}

# Add the output to the clipboard
$output -join "`n" | Set-Clipboard

# Print the output to the screen
Write-Host ($output -join "`n")
