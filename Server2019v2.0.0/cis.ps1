# Install IIS Website
Install-WindowsFeature -name Web-Server -IncludeManagementTools
 
# Setup directory
New-Item C:\ImageBuilderWebApp -type Directory

# GitHub repository information
$githubRepoUrl = "https://github.com/Rishabh-Tripathi16/hardening.git"
$branch = "main"  # Replace with your branch name
$folderToCopy = "Server2019v2.0.0"  # Replace with the folder you want to copy
$destinationDirectory = "C:\ImageBuilderWebApp"  # Replace with your destination directory

# Clone the GitHub repository
git clone --branch $branch --single-branch $githubRepoUrl

# Copy the folder to the destination directory
Copy-Item -Path "$($PWD.Path)\$folderToCopy" -Destination $destinationDirectory -Recurse -Force
 
# Create site
New-IISSite -Name "ImageBuilderWebApp" -BindingInformation "*:8080:" -PhysicalPath "C:\ImageBuilderWebApp" 
 
# # Open firewall port for 8080
# New-NetFirewallRule -DisplayName "Allow Outbound Port 8080" -Direction Inbound -LocalPort 8080 -Protocol TCP -Action Allow

cmd.exe /c C:\Server2019v2.0.0\cis.bat

# # Optionally, remove the cloned repository if you don't need it
# Remove-Item -Path "$($PWD.Path)\YourRepo" -Recurse -Force

