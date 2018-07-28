# Windows 10 Cleanup

Windows 10 comes with a lot of annoying pre-installed so called "Apps". Here's
how to get rid of them:

    Get-AppxPackage *[package name]* | Remove-AppxPackage

Here are some package names to delete:

    alarm
    camera
    zune
    xbox
    skype
    store
