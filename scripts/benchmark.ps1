# PowerShell benchmark script

Write-Host "⚡ Running Polyverse benchmarks..." -ForegroundColor Cyan

# Benchmark hub
Write-Host "`n📊 Benchmarking Hub..." -ForegroundColor Yellow
$hubStart = Get-Date
Invoke-WebRequest -Uri "http://localhost:8000/health" -UseBasicParsing | Out-Null
$hubEnd = Get-Date
$hubTime = ($hubEnd - $hubStart).TotalMilliseconds
Write-Host "Hub response time: $hubTime ms" -ForegroundColor Green

# Benchmark Rust Signal
Write-Host "`n📊 Benchmarking Rust Signal..." -ForegroundColor Yellow
$rustStart = Get-Date
Invoke-WebRequest -Uri "http://localhost:8080/health" -UseBasicParsing | Out-Null
$rustEnd = Get-Date
$rustTime = ($rustEnd - $rustStart).TotalMilliseconds
Write-Host "Rust Signal response time: $rustTime ms" -ForegroundColor Green

# Benchmark Go Orchestrator
Write-Host "`n📊 Benchmarking Go Orchestrator..." -ForegroundColor Yellow
$goStart = Get-Date
Invoke-WebRequest -Uri "http://localhost:8081/health" -UseBasicParsing | Out-Null
$goEnd = Get-Date
$goTime = ($goEnd - $goStart).TotalMilliseconds
Write-Host "Go Orchestrator response time: $goTime ms" -ForegroundColor Green

Write-Host "`n✅ Benchmark complete!" -ForegroundColor Cyan

