# Enables the local admin for domain joined machines. This allows ansible to connect via winrm to do post config.

Set-GPRegistryValue -Name "Default Domain Policy" -Key "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -ValueName "LocalAccountTokenFilterPolicy" -Type DWord -Value 1
