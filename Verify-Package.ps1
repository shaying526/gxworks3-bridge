[CmdletBinding()]
param()
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$bundleRoot = [IO.Path]::GetFullPath($PSScriptRoot)
$bundlePrefix = $bundleRoot.TrimEnd('\') + '\'
$manifestPath = Join-Path $bundleRoot 'SHA256SUMS.json'
$manifest = Get-Content -LiteralPath $manifestPath -Raw -Encoding UTF8 | ConvertFrom-Json
if ($manifest.schemaVersion -ne 1 -or $manifest.algorithm -ne 'SHA256' -or @($manifest.files).Count -lt 1) {
    throw 'Unsupported or empty package manifest.'
}
$seen = New-Object 'Collections.Generic.HashSet[string]' ([StringComparer]::OrdinalIgnoreCase)
$failures = New-Object 'Collections.Generic.List[object]'
$checked = 0
foreach ($entry in $manifest.files) {
    $relative = [string]$entry.path
    if ([string]::IsNullOrWhiteSpace($relative) -or [IO.Path]::IsPathRooted($relative) -or $relative.Contains(':') -or
        @($relative.Split(@('/','\'), [StringSplitOptions]::None) | Where-Object { $_ -eq '..' -or $_ -eq '.' -or $_ -eq '' }).Count -gt 0 -or
        $relative -eq 'SHA256SUMS.json' -or -not $seen.Add($relative.Replace('/', '\'))) {
        throw 'Unsafe, duplicate or self-referencing manifest path.'
    }
    $full = [IO.Path]::GetFullPath((Join-Path $bundleRoot $relative))
    if (-not $full.StartsWith($bundlePrefix, [StringComparison]::OrdinalIgnoreCase)) { throw 'Manifest path escapes package.' }
    for ($current = $full; $current -and $current.Length -ge $bundleRoot.Length; $current = [IO.Path]::GetDirectoryName($current)) {
        if ((Test-Path -LiteralPath $current) -and ((Get-Item -LiteralPath $current -Force).Attributes -band [IO.FileAttributes]::ReparsePoint)) {
            throw 'Package verification does not follow reparse points.'
        }
    }
    if (-not (Test-Path -LiteralPath $full -PathType Leaf)) {
        $failures.Add([pscustomobject]@{ path = $relative; reason = 'missing' }); continue
    }
    $file = Get-Item -LiteralPath $full
    if ($file.Length -ne [long]$entry.bytes -or (Get-FileHash -LiteralPath $full -Algorithm SHA256).Hash.ToLowerInvariant() -ne [string]$entry.sha256) {
        $failures.Add([pscustomobject]@{ path = $relative; reason = 'size_or_sha256_mismatch' })
    }
    $checked++
}
foreach ($item in Get-ChildItem -LiteralPath $bundleRoot -Force -Recurse) {
    if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) { throw 'Unexpected reparse point in package.' }
    if ($item.PSIsContainer) { continue }
    $relative = $item.FullName.Substring($bundlePrefix.Length)
    if ($relative -ne 'SHA256SUMS.json' -and -not $seen.Contains($relative)) {
        $failures.Add([pscustomobject]@{ path = $relative.Replace('\', '/'); reason = 'unexpected_file' })
    }
}
[pscustomobject]@{ ok = $failures.Count -eq 0; checkedFiles = $checked; failures = @($failures.ToArray());
    scope = 'Package byte integrity only; not a signature, GX project validity, compilation or platform acceptance.' } | ConvertTo-Json -Depth 5
if ($failures.Count -gt 0) { throw 'Package integrity verification failed. See JSON failures above.' }
