$e = [char]27
$gold  = "${e}[38;2;224;175;104m"
$coral = "${e}[38;2;247;118;142m"
$dim   = "${e}[38;2;110;116;125m"
$grn   = "${e}[38;2;158;206;106m"
$blu   = "${e}[38;2;122;162;247m"
$pur   = "${e}[38;2;187;154;247m"
$r     = "${e}[0m"
$bld   = "${e}[1m"

$IW = 34

$brand = @($env:ZBRAND, $env:USERNAME, "unknown") | Where-Object { $_ } | Select-Object -First 1
$brand = $brand.ToUpper().Substring(0, [Math]::Min(8, $brand.Length))
$n = $brand.Length
$colors = @($coral, $blu, $grn, $gold, $pur)

$brandParts = @()
for ($i = 0; $i -lt $n; $i++) {
    $c = $colors[$i % $colors.Length]
    $brandParts += "$c$($brand[$i])$r"
}
$brandFull = "${coral}<${r} $($brandParts -join " ") ${coral}>${r}"
$brandVL = $n * 2 + 3
$brandP = $IW - $brandVL
$brandL = [Math]::Floor($brandP / 2)
$brandR = $brandP - $brandL

$buildText = ">>  LET'S BUILD  <<"
$buildVL = $buildText.Length
$buildP = $IW - $buildVL
$buildL = [Math]::Floor($buildP / 2)
$buildR = $buildP - $buildL

$empty = " " * $IW

Write-Host ""
Write-Host "${dim}  +$('-'*$IW)+$r"
Write-Host "${dim}  |$r$empty${dim}|$r"
Write-Host "${dim}  |$r$(' '*$buildL)${gold}${bld}${buildText}${r}$(' '*$buildR)${dim}|$r"
Write-Host "${dim}  |$r$empty${dim}|$r"
Write-Host "${dim}  |$r$(' '*$brandL)${brandFull}$(' '*$brandR)${dim}|$r"
Write-Host "${dim}  |$r$empty${dim}|$r"
Write-Host "${dim}  +$('-'*$IW)+$r"
Write-Host ""
