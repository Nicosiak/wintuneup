@echo off
setlocal EnableDelayedExpansion

:: ============================================================
:: System Maintenance Main Menu
:: This script performs several tasks:
::   1. Set Working Directory & Power Plan
::   2. Run Windows Defender Virus Scan
::   3. Disk Check & Repair
::   4. System File Checker & DISM Health Check
::   5. Disk Cleanup
::   6. Windows Update
::   7. Network Maintenance & Temp File Cleanup
::   8. Optional Tools (Energy Report, Disk Defragmentation)
::   9. Display Storage Information (in GB)
::   0. Exit
:: ============================================================

:MENU
cls
echo ============================================================
echo             System Maintenance Main Menu
echo ============================================================
echo 1. Set Working Directory & Power Plan
echo 2. Windows Defender Virus Scan
echo 3. Disk Check & Repair
echo 4. System File Checker & DISM Health Check
echo 5. Disk Cleanup
echo 6. Windows Update
echo 7. Network Maintenance & Temp File Cleanup
echo 8. Optional Tools (Energy Report, Defrag)
echo 9. Display Storage Information (in GB)
echo 0. Exit
echo ============================================================
set /p option="Choose an option: "

if "%option%"=="1" goto Step1
if "%option%"=="2" goto Step2
if "%option%"=="3" goto Step3
if "%option%"=="4" goto Step4
if "%option%"=="5" goto Step5
if "%option%"=="6" goto Step6
if "%option%"=="7" goto Step7
if "%option%"=="8" goto Step8
if "%option%"=="9" goto Step9
if "%option%"=="0" goto End

echo Invalid option. Please try again.
pause
goto MENU

:Step1
cls
echo ============================================================
echo Step 1: Setting Working Directory and Power Plan
echo ============================================================
echo Changing directory to C:\Windows\System32...
cd /d C:\Windows\System32
echo Configuring power plan...
:: Duplicate and select the specified power plan.
:: (Make sure the GUID matches your desired power plan.)
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg -selectscheme e9a42b02-d5df-448d-aa00-03f14749eb61
echo.
echo Step 1 completed.
pause
goto MENU

:Step2
cls
echo ============================================================
echo Step 2: Running Windows Defender Virus Scan
echo ============================================================
:: Start Windows Defender (if not already running)
net start WinDefend
:: Update virus definitions
mpcmdrun.exe -SignatureUpdate
:: Run a full scan (ScanType 3)
mpcmdrun.exe -Scan -ScanType 3
echo.
echo Windows Defender scan completed successfully!
pause
goto MENU

:Step3
cls
echo ============================================================
echo Step 3: Disk Check and Repair (C:)
echo ============================================================
:: Run CHKDSK with fix (/f) and recovery (/r) options
chkdsk C: /f /r
:: Run a spot fix on the drive
chkdsk C: /spotfix
echo.
echo Disk check completed.
pause
goto MENU

:Step4
cls
echo ============================================================
echo Step 4: System File Checker and DISM Health Check
echo ============================================================
:: Run System File Checker to scan and repair system files
sfc /scannow
:: Use DISM to scan for and repair Windows image corruption
dism /online /cleanup-image /scanhealth
dism /online /cleanup-image /restorehealth
dism /online /cleanup-image /startcomponentcleanup
echo.
echo System health check completed.
pause
goto MENU

:Step5
cls
echo ============================================================
echo Step 5: Disk Cleanup
echo ============================================================
:: Launch Disk Cleanup in automatic mode
cleanmgr /autorun
pause
goto MENU

:Step6
cls
echo ============================================================
echo Step 6: Initiating Windows Updates
echo ============================================================
echo Starting update scan...
UsoClient StartScan
timeout /t 10
echo Downloading updates...
UsoClient StartDownload
timeout /t 10
echo Installing updates...
UsoClient StartInstall
timeout /t 10
echo.
echo Windows Update commands executed.
pause
goto MENU

:Step7
cls
echo ============================================================
echo Step 7: Network Maintenance & Temporary File Cleanup
echo ============================================================
echo Flushing DNS...
ipconfig /flushdns
echo Resetting network settings...
netsh winsock reset
netsh int ip reset
echo Clearing temporary files...
del /q /f /s "%temp%\*"
echo.
echo Network maintenance and temp file cleanup completed.
pause
goto MENU

:Step8
cls
echo ============================================================
echo Optional Tools Menu
echo ============================================================
echo 1. Generate Energy Efficiency Report
echo 2. Disk Defragmentation (HDD Only)
echo 0. Back to Main Menu
echo ============================================================
set /p opt2="Choose an option: "
if "%opt2%"=="1" goto EnergyReport
if "%opt2%"=="2" goto Defrag
if "%opt2%"=="0" goto MENU
goto Step8

:EnergyReport
cls
echo ============================================================
echo Generating Energy Efficiency Report...
echo ============================================================
:: Generates an HTML report in your user profile folder.
powercfg /energy /output "%UserProfile%\energy-report.html"
echo Energy report generated at %UserProfile%\energy-report.html
pause
goto Step8

:Defrag
cls
echo ============================================================
echo Disk Defragmentation (HDD Only)
echo ============================================================
:: Uncomment the next line if you have an HDD and wish to defrag:
:: defrag C: /O
echo (Defragmentation command is commented out by default.)
pause
goto Step8

:Step9
cls
echo ============================================================
echo Step 9: Displaying Storage Information in GB
echo ============================================================
:: Uses PowerShell to retrieve storage information for fixed disks.
powershell -Command "Get-WmiObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 } | ForEach-Object { $free = [math]::round($_.FreeSpace/1GB,2); $total = [math]::round($_.Size/1GB,2); Write-Output ('Drive: {0} - Free: {1} GB / Total: {2} GB' -f $_.DeviceID, $free, $total) }"
pause
goto MENU

:End

echo Exiting...
pause
exit
