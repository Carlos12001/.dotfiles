Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "C:\Users\carlos\starship.toml"
function random {
    Set-Location -Path ~/Desktop/random
}
function repos {
    Set-Location -Path ~/Repos
}
function desktop {
    Set-Location -Path ~/Desktop
}
function Desktop {
    Set-Location -Path ~/Desktop
}
function reboot {
    shutdown /r /t 0
}
function sh {
    param (
        [string]$time = "now"
    )

    switch ($time) {
        "now" {
            shutdown /s /t 0
        }
        default {
            if ($time -match '^\d+$') {
                shutdown /s /t $time
            }
            else {
                Write-Host "Usage: shutdown [now|seconds]"
            }
        }
    }
}
function retrosync {
    param (
        [string]$command
    )
    
    # RetroArch saves directory
    $retroarchDir = "C:\RetroArch-Win64\saves"
    
    function Execute-GitCommands {
        switch ($command) {
            "pull" {
                Write-Host "Pulling latest saves from repository..." -ForegroundColor Cyan
                git pull
            }
            "push" {
                Write-Host "Checking for modified and new RetroArch saves..." -ForegroundColor Cyan
                $changes = git status --short

                if (-not $changes) {
                    Write-Host "No changes to commit." -ForegroundColor Yellow
                    return
                }

                Write-Host "`nChanged files:" -ForegroundColor Gray
                $changes | ForEach-Object {
                    if ($_ -match "^\s*M") {
                        Write-Host "MODIFIED   $($_.Substring(3))" -ForegroundColor Yellow
                    } elseif ($_ -match "^\s*A") {
                        Write-Host "ADDED      $($_.Substring(3))" -ForegroundColor Green
                    } elseif ($_ -match "^\?\?") {
                        Write-Host "NEW FILE   $($_.Substring(3))" -ForegroundColor Cyan
                    } else {
                        Write-Host "OTHER      $($_)" -ForegroundColor DarkGray
                    }
                }

                Write-Host "Pushing RetroArch saves to repository..." -ForegroundColor Green
                # Add all files in the saves directory
                git add .
                git commit -m "feat: update RetroArch save files"
                git push
            }
            "status" {
                Write-Host "Repository status:" -ForegroundColor Yellow
                git status
            }
            "restore" {
                Write-Host "WARNING: This will restore all files to the last commit!" -ForegroundColor Red
                $confirmation = Read-Host "Are you sure? (y/N)"
                if ($confirmation -eq 'y') {
                    git reset --hard
                    git clean -fd
                    Write-Host "Files restored successfully." -ForegroundColor Green
                } else {
                    Write-Host "Operation cancelled." -ForegroundColor Yellow
                }
            }
            "list" {
                Write-Host "Tracked save files:" -ForegroundColor Cyan
                git ls-files
            }
            "cd" {
                Set-Location $retroarchDir
                Write-Host "Changed to RetroArch saves directory:" -ForegroundColor Green
                Write-Host $retroarchDir -ForegroundColor Cyan
            }
            "go" {
                Set-Location $retroarchDir
                Write-Host "Changed to RetroArch saves directory:" -ForegroundColor Green
                Write-Host $retroarchDir -ForegroundColor Cyan
            }
            "open" {
                Write-Host "Opening RetroArch saves directory in Explorer..." -ForegroundColor Cyan
                explorer $retroarchDir
            }
            default {
                Write-Host "RetroArch Save Sync (rsync)" -ForegroundColor Magenta
                Write-Host "Usage: rsync [command]" -ForegroundColor White
                Write-Host ""
                Write-Host "Git Commands:" -ForegroundColor Yellow
                Write-Host "  pull    - Pull latest saves from repository"
                Write-Host "  push    - Push current saves to repository"
                Write-Host "  status  - Show repository status"
                Write-Host "  restore - Restore saves to last commit (CAUTION!)"
                Write-Host "  list    - List tracked save files"
                Write-Host ""
                Write-Host "Navigation Commands:" -ForegroundColor Yellow
                Write-Host "  cd/go   - Change to RetroArch saves directory"
                Write-Host "  open    - Open saves directory in Explorer"
            }
        }
    }
    
    if (Test-Path $retroarchDir) {
        # Handle navigation commands differently
        if ($command -eq "cd" -or $command -eq "go") {
            Set-Location $retroarchDir
            Write-Host "Changed to RetroArch saves directory:" -ForegroundColor Green
            Write-Host $retroarchDir -ForegroundColor Cyan
            return
        }
        
        Push-Location $retroarchDir
        try {
            # Check if it's a git repository
            if (-not (Test-Path ".git")) {
                Write-Host "Error: $retroarchDir is not a git repository." -ForegroundColor Red
                Write-Host "Initialize it with 'git init' first." -ForegroundColor Yellow
                return
            }
            
            # Check for dubious ownership error
            $gitStatus = git status 2>&1
            if ($gitStatus -match "dubious ownership") {
                Write-Host "Fixing git ownership issue..." -ForegroundColor Yellow
                git config --global --add safe.directory $retroarchDir
                Write-Host "Ownership issue fixed. Running command..." -ForegroundColor Green
            }
            
            Execute-GitCommands
        }
        finally {
            Pop-Location
        }
    } else {
        Write-Host "Error: RetroArch saves directory not found at: $retroarchDir" -ForegroundColor Red
        exit 1
    }
}
