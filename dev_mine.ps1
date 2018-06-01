# Description: Boxstarter Script
# Author: Microsoft
# Common dev settings for desktop app development

Disable-UAC

#--- Windows Features ---
Set-WindowsExplorerOptions -EnableShowFileExtensions

#--- File Explorer Settings ---
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

#--- Windows Subsystems/Features ---
choco install -y Microsoft-Hyper-V-All -source windowsFeatures
choco install -y Microsoft-Windows-Subsystem-Linux -source windowsfeatures

#--- Tools ---
choco install -y visualstudio2017community  # See this for install args: https://chocolatey.org/packages/VisualStudio2017Community
choco install -y sysinternals
# choco install -y docker-for-windows
choco install -y emacs64 neovim
choco install -y ripgrep

# golang
# choco install -y golang
# go get -u github.com/sourcegraph/go-langserver
# python
choco install -y python3
pip3 install --upgrade neovim
pip3 install --upgrade python-language-server

# redirect tools from wsl
function RedirectWslCommand($cmd)
{
    & "$env:ChocolateyInstall/tools/shimgen" -o "$env:ChocolateyToolsLocation/bin/$cmd.exe" -p (gcm wsl).Path -c $cmd
}

RedirectWslCommand git
RedirectWslCommand aspell

# TODO: should pass install args to VS2017 to install additional options

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
