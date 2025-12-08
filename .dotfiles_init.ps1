git init --bare $env:USERPROFILE/.dotfiles
git --git-dir=$env:USERPROFILE/.dotfiles --work-tree=$env:USERPROFILE config --local status.showUntrackedFiles no

Add-Content -Path $PROFILE -Value 'Invoke-Expression (& { (zoxide init powershell | Out-String) })

$git = "git.exe"
function git-dot {& $git "--git-dir=$env:USERPROFILE\.dotfiles" "--work-tree=$env:USERPROFILE" $args}
Set-Alias dot git-dot

function prompt {
    $p = $executionContext.SessionState.Path.CurrentLocation
    $osc7 = ""
    if ($p.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $p.ProviderPath -Replace "\\", "/"
        $osc7 = "$ansi_escape[32m${env:USERNAME}@${env:COMPUTERNAME}${ansi_escape}[0m:${provider_path}"
    }
    "${osc7}$("$" * ($nestedPromptLevel + 1)) ";
}

function y {
  $tmp = (New-TemporaryFile).FullName
  [System.Environment]::SetEnvironmentVariable("YAZI_CWD", $tmp, "User")
  yazi $args --cwd-file="$tmp"
  $cwd = Get-Content -Path $tmp -Encoding UTF8
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
    Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
  }
  Remove-Item -Path $tmp
}
'
