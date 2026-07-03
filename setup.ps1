# Dev Environment Setup Script
# Run as Administrator: .\setup.ps1

Write-Host "Installing Git..." -ForegroundColor Cyan
winget install --id Git.Git -e --accept-package-agreements --accept-source-agreements

Write-Host "Installing .NET 8 SDK..." -ForegroundColor Cyan
winget install --id Microsoft.DotNet.SDK.8 -e --accept-package-agreements --accept-source-agreements

Write-Host "Installing Node.js LTS..." -ForegroundColor Cyan
winget install --id OpenJS.NodeJS.LTS -e --accept-package-agreements --accept-source-agreements

Write-Host "Installing uv (Python package manager)..." -ForegroundColor Cyan
winget install --id astral-sh.uv -e --accept-package-agreements --accept-source-agreements

Write-Host "Installing Docker Desktop..." -ForegroundColor Cyan
winget install --id Docker.DockerDesktop -e --accept-package-agreements --accept-source-agreements

Write-Host "Installing VS Code..." -ForegroundColor Cyan
winget install --id Microsoft.VisualStudioCode -e --accept-package-agreements --accept-source-agreements

Write-Host ""
Write-Host "All installs complete. Close and reopen PowerShell (as Administrator) to refresh PATH." -ForegroundColor Green
Write-Host "Docker Desktop will require a reboot before first use." -ForegroundColor Yellow

Write-Host "Installing Ollama..." -ForegroundColor Cyan
winget install --id Ollama.Ollama -e --accept-package-agreements --accept-source-agreements
