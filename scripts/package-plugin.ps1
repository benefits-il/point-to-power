# package-plugin.ps1
# Builds the downloadable PLUGIN zip for PointToPower.
# The zip contains the `point-to-power/` plugin folder (with .claude-plugin/plugin.json,
# agents/, commands/, skills/, references/, shared/). A learner downloads it, extracts it,
# and drops the `point-to-power/` folder into their Cowork/Claude Code plugins folder.
#
# Marketplace install is the other path and needs no zip:
#   /plugin marketplace add benefits-il/point-to-power
#   /plugin install point-to-power@benefits-plugins
#
# Usage (from anywhere):  pwsh ./scripts/package-plugin.ps1   (or powershell.exe)

$ErrorActionPreference = 'Stop'

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot  = Split-Path -Parent $scriptDir
$pluginDir = Join-Path $repoRoot 'point-to-power'
$outDir    = Join-Path $repoRoot 'download'
$outZip    = Join-Path $outDir 'point-to-power-plugin.zip'

# Sanity: the plugin manifest must exist.
$manifest = Join-Path $pluginDir '.claude-plugin/plugin.json'
if (-not (Test-Path $manifest)) {
    throw "Plugin manifest not found at $manifest. Are you in the point-to-power repo?"
}

if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir | Out-Null }
if (Test-Path $outZip) { Remove-Item $outZip -Force }

# Build the zip MANUALLY with forward-slash entry names so it extracts correctly on
# Windows, macOS, and Linux. (Windows PowerShell 5.1's Compress-Archive writes backslash
# entry names, which macOS/Linux unzip treats as a literal filename and mangles.)
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$parent = Split-Path -Parent $pluginDir   # so entries are prefixed with "point-to-power/"
$files = Get-ChildItem -Path $pluginDir -Recurse -File

$zip = [System.IO.Compression.ZipFile]::Open($outZip, [System.IO.Compression.ZipArchiveMode]::Create)
try {
    foreach ($f in $files) {
        $rel = $f.FullName.Substring($parent.Length + 1) -replace '\\', '/'
        [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $f.FullName, $rel, [System.IO.Compression.CompressionLevel]::Optimal) | Out-Null
    }
} finally {
    $zip.Dispose()
}

$zipItem = Get-Item $outZip
$kb = [math]::Round($zipItem.Length / 1KB, 1)
$version = (Get-Content $manifest -Raw | ConvertFrom-Json).version

Write-Output "Built plugin zip:"
Write-Output "  $outZip"
Write-Output "  version $version, $kb KB"
Write-Output ""
Write-Output "Verify contents:"
$archive = [System.IO.Compression.ZipFile]::OpenRead($outZip)
$entries = $archive.Entries.Count
$hasManifest = $archive.Entries | Where-Object { $_.FullName -eq 'point-to-power/.claude-plugin/plugin.json' }
$backslashes = $archive.Entries | Where-Object { $_.FullName -match '\\' }
$archive.Dispose()
Write-Output "  $entries entries"
if ($hasManifest) { Write-Output "  OK: point-to-power/.claude-plugin/plugin.json present (forward slashes)" }
else { Write-Output "  WARNING: plugin.json not at expected path inside zip" }
if ($backslashes) { Write-Output "  WARNING: some entries use backslashes (not cross-platform)" }
else { Write-Output "  OK: all entries use forward slashes" }
