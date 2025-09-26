git init --bare $env:USERPROFILE/.dotfiles
git --git-dir=$env:USERPROFILE/.dotfiles --work-tree=$env:USERPROFILE config --local status.showUntrackedFiles no

Add-Content -Path $PROFILE -Value '$git = "git.exe"
function git-dot {& $git "--git-dir=$env:USERPROFILE\.dotfiles" "--work-tree=$env:USERPROFILE" $args}
Set-Alias dot git-dot'
