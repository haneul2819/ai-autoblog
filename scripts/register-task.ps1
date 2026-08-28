<#
.SYNOPSIS
  AI 자동 블로그를 Windows 작업 스케줄러에 등록한다. 하루 세 번(09:00 / 14:00 / 20:00).

.DESCRIPTION
  관리자 권한이 필요 없다. 로그인한 사용자 계정으로만 도는 작업이라
  PC가 켜져 있고 로그인돼 있을 때만 실행된다.

  StartWhenAvailable을 켜 두었으므로 PC가 꺼져 있어 놓친 회차는 다음에 켜졌을 때
  한 번 따라잡는다. 그보다 큰 공백은 run-scheduled.ps1 의 "오늘 몇 편 나왔나" 계산이
  메운다.

.PARAMETER TaskName
  작업 이름. 기본값 AI-AutoBlog.

.PARAMETER Times
  실행 시각 목록. 기본값 09:00, 14:00, 20:00.

.PARAMETER Unregister
  등록을 해제한다.

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File scripts\register-task.ps1
  powershell -ExecutionPolicy Bypass -File scripts\register-task.ps1 -Times 08:00,13:00,19:00
  powershell -ExecutionPolicy Bypass -File scripts\register-task.ps1 -Unregister
#>
[CmdletBinding()]
param(
  [string]$TaskName = 'AI-AutoBlog',
  [string[]]$Times = @('09:00', '14:00', '20:00'),
  [switch]$Unregister
)

$ErrorActionPreference = 'Stop'

try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch { }

$Root = Split-Path -Parent $PSScriptRoot
$runner = Join-Path $Root 'scripts\run-scheduled.ps1'

if ($Unregister) {
  $existing = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
  if ($existing) {
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
    Write-Host "등록 해제했다: $TaskName"
  } else {
    Write-Host "등록된 작업이 없다: $TaskName"
  }
  return
}

if (-not (Test-Path -LiteralPath $runner)) {
  throw "실행기를 찾지 못했다: $runner"
}

$action = New-ScheduledTaskAction `
  -Execute 'powershell.exe' `
  -Argument ('-NoProfile -NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -File "{0}"' -f $runner) `
  -WorkingDirectory $Root

$triggers = @()
foreach ($time in $Times) {
  $triggers += New-ScheduledTaskTrigger -Daily -At $time
}

$settings = New-ScheduledTaskSettingsSet `
  -StartWhenAvailable `
  -AllowStartIfOnBatteries `
  -DontStopIfGoingOnBatteries `
  -MultipleInstances IgnoreNew `
  -ExecutionTimeLimit (New-TimeSpan -Hours 2) `
  -RestartCount 1 `
  -RestartInterval (New-TimeSpan -Minutes 10)

$principal = New-ScheduledTaskPrincipal `
  -UserId ('{0}\{1}' -f $env:USERDOMAIN, $env:USERNAME) `
  -LogonType Interactive `
  -RunLevel Limited

Register-ScheduledTask `
  -TaskName $TaskName `
  -Action $action `
  -Trigger $triggers `
  -Settings $settings `
  -Principal $principal `
  -Description 'AI 자동 블로그: 하루 세 번 글을 생성해 저장소에 커밋한다.' `
  -Force | Out-Null

Write-Host ''
Write-Host "등록 완료: $TaskName"
Write-Host ("  실행 시각  {0}" -f ($Times -join ', '))
Write-Host ("  실행 대상  {0}" -f $runner)
Write-Host ''
Write-Host '확인:      Get-ScheduledTask -TaskName ''AI-AutoBlog'' | Get-ScheduledTaskInfo'
Write-Host '즉시 실행: Start-ScheduledTask -TaskName ''AI-AutoBlog'''
Write-Host '해제:      powershell -ExecutionPolicy Bypass -File scripts\register-task.ps1 -Unregister'
