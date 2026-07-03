# Check git sync status across all repos
# Run from anywhere: .\check-repos.ps1

$repos = @(
    "game-of-life-api",
    "parcel-platform",
    "lpl-rag-system",
    "react-agent"
)

foreach ($repo in $repos) {
    $path = "C:\Projects\$repo"
    Write-Host ""
    Write-Host "=======================================" -ForegroundColor Cyan
    Write-Host " $repo" -ForegroundColor Cyan
    Write-Host "=======================================" -ForegroundColor Cyan

    if (-not (Test-Path $path)) {
        Write-Host "NOT FOUND: $path" -ForegroundColor Yellow
        continue
    }

    Set-Location $path

    # Fetch latest from remote without merging, so status is accurate
    git fetch --quiet

    $branch = git rev-parse --abbrev-ref HEAD
    Write-Host "Branch: $branch" -ForegroundColor DarkGray

    $status = git status --porcelain
    if ($status) {
        Write-Host "UNCOMMITTED CHANGES:" -ForegroundColor Red
        git status --short
    } else {
        Write-Host "Working tree clean" -ForegroundColor Green
    }

    $ahead = git rev-list --count "origin/$branch..$branch" 2>$null
    $behind = git rev-list --count "$branch..origin/$branch" 2>$null

    if ($ahead -gt 0) {
        Write-Host "AHEAD of origin by $ahead commit(s) - needs push" -ForegroundColor Yellow
    }
    if ($behind -gt 0) {
        Write-Host "BEHIND origin by $behind commit(s) - needs pull" -ForegroundColor Yellow
    }
    if ($ahead -eq 0 -and $behind -eq 0) {
        Write-Host "In sync with origin/$branch" -ForegroundColor Green
    }
}

Set-Location C:\Projects
Write-Host ""
Write-Host "Done." -ForegroundColor Cyan
