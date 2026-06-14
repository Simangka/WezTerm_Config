$ESC = [char]27
$R = "$ESC[0m"
$B  = "$ESC[1m"
$D  = "$ESC[38;2;110;116;125m"
$CR = "$ESC[38;2;247;118;142m"
$GR = "$ESC[38;2;158;206;106m"
$BL = "$ESC[38;2;122;162;247m"
$GO = "$ESC[38;2;224;175;104m"
$PU = "$ESC[38;2;187;154;247m"

$reg = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
$osName = (Get-ItemProperty $reg).ProductName
$build  = (Get-ItemProperty $reg).CurrentBuild
$kernel = "10.0.$build"
$cpu    = (Get-ItemProperty "HKLM:\HARDWARE\DESCRIPTION\System\CentralProcessor\0").ProcessorNameString.Trim()

$cs = Get-CimInstance Win32_ComputerSystem
$os = Get-CimInstance Win32_OperatingSystem
$totalRAM = [math]::Round($cs.TotalPhysicalMemory / 1GB, 1)
$usedRAM  = $totalRAM - [math]::Round($os.FreePhysicalMemory / 1MB, 1)

$upDur = (Get-Date) - $os.LastBootUpTime
$upParts = @()
if ($upDur.Days -gt 0) { $upParts += "$($upDur.Days)d" }
if ($upDur.Hours -gt 0 -or $upDur.Days -gt 0) { $upParts += "$($upDur.Hours)h" }
$upParts += "$($upDur.Minutes)m"
$uptimeStr = $upParts -join " "

if ($build -ge 22000) { $osName = $osName -replace "Windows 10", "Windows 11" }

$info = @(
    @("OS",       $osName),
    @("Host",     "$env:COMPUTERNAME"),
    @("Kernel",   $kernel),
    @("Uptime",   $uptimeStr),
    @("CPU",      $cpu),
    @("RAM",      "$($usedRAM)G / $($totalRAM)G"),
    @("Shell",    "PowerShell $($PSVersionTable.PSVersion)"),
    @("Terminal", "WezTerm")
)

$boxW = 48

function Print($s) {
    Write-Host $s
}

$brand = @($env:ZBRAND, $env:USERNAME, "unknown") | Where-Object { $_ } | Select-Object -First 1
$brand = $brand.ToUpper().Substring(0, [Math]::Min(12, $brand.Length))
$colors = @($CR, $BL, $GR, $GO, $PU)
$headerParts = @()
for ($i = 0; $i -lt $brand.Length; $i++) {
    $c = $colors[$i % $colors.Length]
    $headerParts += "$c $($brand[$i])"
}
$headerText = ($headerParts -join " ") + " $R"
$headerLen = $brand.Length * 3
$headerL = [Math]::Floor(($boxW - 2 - $headerLen) / 2)
$headerR = $boxW - 2 - $headerLen - $headerL
Print "$D$B+$R$D$('-'*($boxW-2))$B+$R"
Print "$D|$R$(' '*$headerL)$headerText$(' '*$headerR)$D|$R"
Print "$D|$R$(' '*($boxW-2))$D|$R"

foreach ($i in $info) {
    $key = $i[0]
    $val = $i[1]
    $vlen = $val.Length
    if ($vlen -gt 29) { $val = $val.Substring(0,26) + "..."; $vlen = 29 }
    $line = "  $CR$B$($key.PadRight(8))$R $D|$R  $GR$val$R"
    $padLen = $boxW - 16 - $vlen
    if ($padLen -gt 0) { $line += " " * $padLen }
    Print "$D|$R$line$D|$R"
}

Print "$D|$R$(' '*($boxW-2))$D|$R"
Print "$D$B+$R$D$('-'*($boxW-2))$B+$R"
