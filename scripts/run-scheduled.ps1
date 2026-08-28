<#
.SYNOPSIS
  AI 자동 블로그 — 예약 실행기. 작업 스케줄러가 하루 세 번 이 스크립트를 부른다.

.DESCRIPTION
  오늘 이미 몇 편이 나왔는지 세고, 하루 목표(config.json의 postsPerDay)에
  모자란 만큼만 연속으로 생성한다. PC가 꺼져 있어 놓친 회차를 이렇게 메운다.
  단 마감 시각(cutoffHour, 기본 22시)을 넘기면 그날 분은 접는다.
  다음 날로 넘겨 몰아쓰지 않는다.

  실패하면 5분 뒤 한 번만 다시 시도하고, 그래도 안 되면 로그만 남기고 끝낸다.

.PARAMETER Max
  이번 실행에서 만들 최대 편수. 0이면 부족분 전체.

.PARAMETER Force
  마감 시각과 하루 목표를 무시하고 한 편 생성. 손으로 돌려 볼 때 쓴다.

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File scripts\run-scheduled.ps1
  powershell -ExecutionPolicy Bypass -File scripts\run-scheduled.ps1 -Force
#>
[CmdletBinding()]
param(
  [int]$Max = 0,
  [switch]$Force
)

$ErrorActionPreference = 'Stop'

try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch { }

$Root = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $Root

# ── 로그 ──────────────────────────────────────────────────────────────────
$logDir = Join-Path $Root 'logs'
if (-not (Test-Path -LiteralPath $logDir)) {
  New-Item -ItemType Directory -Path $logDir -Force | Out-Null
}
$logFile = Join-Path $logDir ((Get-Date -Format 'yyyy-MM') + '.log')
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

function Write-Log {
  param([string]$Message)
  $line = '{0} | {1}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $Message
  [System.IO.File]::AppendAllText($logFile, $line + [Environment]::NewLine, $utf8NoBom)
  Write-Host $line
}

# ── 설정 ──────────────────────────────────────────────────────────────────
$configPath = Join-Path $Root 'config.json'
if (-not (Test-Path -LiteralPath $configPath)) {
  Write-Log 'ABORT | config.json 이 없다.'
  exit 1
}
$config = Get-Content -LiteralPath $configPath -Raw -Encoding UTF8 | ConvertFrom-Json

function Get-Setting {
  param($Object, [string]$Name, $Default)
  if ($null -ne $Object -and $null -ne $Object.PSObject.Properties[$Name] -and
      $null -ne $Object.$Name -and "$($Object.$Name)" -ne '') {
    return $Object.$Name
  }
  return $Default
}

$postsPerDay = [int](Get-Setting $config 'postsPerDay' 3)
$cutoffHour = [int](Get-Setting $config 'cutoffHour' 22)
$mode = [string](Get-Setting $config 'mode' 'draft')

# ── bash 찾기 ─────────────────────────────────────────────────────────────
# System32\bash.exe(WSL)가 아니라 Git for Windows의 bash 여야 한다.
function Resolve-GitBash {
  $candidates = @(
    (Join-Path $env:ProgramFiles 'Git\bin\bash.exe'),
    (Join-Path ${env:ProgramFiles(x86)} 'Git\bin\bash.exe'),
    (Join-Path $env:LOCALAPPDATA 'Programs\Git\bin\bash.exe'),
    'C:\Program Files\Git\bin\bash.exe'
  )
  foreach ($path in $candidates) {
    if ($path -and (Test-Path -LiteralPath $path)) { return $path }
  }
  $found = Get-Command bash.exe -ErrorAction SilentlyContinue
  if ($found -and $found.Source -notmatch '\\System32\\') { return $found.Source }
  return $null
}

$bash = Resolve-GitBash
if (-not $bash) {
  Write-Log 'ABORT | Git Bash(bash.exe)를 찾지 못했다. Git for Windows를 설치하라.'
  exit 1
}

$generator = (Join-Path $Root 'scripts\generate-post.sh') -replace '\\', '/'

# ── 오늘 몇 편 나왔나 ─────────────────────────────────────────────────────
function Get-TodayCount {
  $today = Get-Date -Format 'yyyy-MM-dd'
  $dirs = @('content\posts', 'content\drafts') |
    ForEach-Object { Join-Path $Root $_ } |
    Where-Object { Test-Path -LiteralPath $_ }
  if (-not $dirs) { return 0 }
  return @(Get-ChildItem -Path $dirs -Filter "$today-*.md" -File -ErrorAction SilentlyContinue).Count
}

$todayCount = Get-TodayCount

# ── 이번 실행에서 몇 편을 쓸지 ────────────────────────────────────────────
if ($Force) {
  $needed = 1
} else {
  if ((Get-Date).Hour -ge $cutoffHour) {
    Write-Log ("SKIP | 마감 {0}시가 지나 오늘 분은 접는다 (오늘 {1}/{2}편)" -f $cutoffHour, $todayCount, $postsPerDay)
    exit 0
  }
  $needed = $postsPerDay - $todayCount
}

if ($Max -gt 0 -and $needed -gt $Max) { $needed = $Max }

if ($needed -le 0) {
  Write-Log ("SKIP | 오늘 목표를 이미 채웠다 ({0}/{1}편)" -f $todayCount, $postsPerDay)
  exit 0
}

Write-Log ("RUN | 시작 — 오늘 {0}/{1}편, 이번에 {2}편 보충 (모드 {3})" -f $todayCount, $postsPerDay, $needed, $mode)

# ── 한 편 생성 ────────────────────────────────────────────────────────────
function Invoke-Generate {
  # 성공하면 $true. 세부 결과(제목·소요시간)는 generate-post.sh가 직접 로그에 남긴다.
  & $bash $generator | Out-Host
  return ($LASTEXITCODE -eq 0)
}

$made = 0

for ($i = 1; $i -le $needed; $i++) {
  if (-not $Force -and (Get-Date).Hour -ge $cutoffHour) {
    Write-Log ("STOP | 생성 도중 마감 {0}시를 넘겼다. 남은 분은 포기한다." -f $cutoffHour)
    break
  }

  Write-Log ("RUN | {0}/{1}번째 생성 시도" -f $i, $needed)

  if (Invoke-Generate) {
    $made++
    continue
  }

  Write-Log 'RETRY | 실패. 5분 뒤 한 번만 다시 시도한다.'
  Start-Sleep -Seconds 300

  if (-not $Force -and (Get-Date).Hour -ge $cutoffHour) {
    Write-Log ("ABORT | 재시도 직전 마감 {0}시를 넘겨 중단한다." -f $cutoffHour)
    break
  }

  if (Invoke-Generate) {
    $made++
    continue
  }

  Write-Log 'ABORT | 재시도도 실패했다. 로그만 남기고 끝낸다.'
  Write-Log ("RUN | 종료 — 이번 실행 {0}편 생성" -f $made)
  exit 1
}

Write-Log ("RUN | 종료 — 이번 실행 {0}편 생성 (오늘 누적 {1}편)" -f $made, (Get-TodayCount))
exit 0
