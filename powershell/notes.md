# PowerShell

Notes based on [PowersShell for Sysadmins](https://nostarch.com/powershellsysadmins)

## Getting Started

Display `cmd.exe`-style aliases:

    PS> Get-Alias

Display a list of all commands:

    PS> Get-Command

Get details about a single command:

    PS> Get-Command -Name Get-Alias

There are four types of command:

1. cmdlets: written in other languages
2. functions: written in PowerShell
3. aliases
4. external scripts

In general, commands have the form `Verb-Noun`. Common verb names are:

- `Get`
- `Set`
- `Update`
- `Remove`

Commands can be listed by verb and/or noun:

    PS> Get-Command -Verb Get
    PS> Get-Command -Noun Content
    PS> Get-Command -Verb Get -Noun Content

See help (cmdlet and alias):

    PS> Get-Help
    PS> help

Show usage examples for a command:

    PS> Get-Help Get-ChildItem -Exmaples

Get help on general topics:

    PS> Get-Help about_Core_Commands

Get list of all "about" topics:

    PS> Get-Help -Name About*

Update help files:

    PS> Update-Help