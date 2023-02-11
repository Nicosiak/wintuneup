@echo off

::////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
:: create restore point?
::remove programs
::virus scan
::run automatic system maintenance
::fix registry errors
:: update drives - remove bad drivers
::///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


@echo PC TUNEUP v1 
pause

@echo ////////////////////////////////////////////////////////////////////////////////////////Setting power plan
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg -selectscheme e9a42b02-d5df-448d-aa00-03f14749eb61
pause

@echo ///////////////////////////////////////////////////////////////////////////////////////Virus scan
:: Start the Windows Defender service
net start WinDefend

:: Update Windows Defender
mpcmdrun.exe -SignatureUpdate

:: Run a full scan with Windows Defender
mpcmdrun.exe -Scan -ScanType 3

echo Windows Defender scan completed successfully!
pause



@echo ///////////////////////////////////////////////////////////////////////////////////////Disk checking
:: Disk check and repair
chkdsk C: /f /r

:: Check the disk for bad sectors
chkdsk C: /spotfix

:: Check the file system for errors
@echo //////////////////////////////////////////////////////////////////////////////////////File system checking
pause
sfc /scannow

dism /online /cleanup-image /scanhealth
dism /online /cleanup-image /restorehealth
dism /online /cleanup-image /startcomponentcleanup

@echo //////////////////////////////////////////////////////////////////////////////////////File Cleanup
pause
::Disk Cleanup
cleanmgr /autorun

::Defrag
defrag C: /f /v

:: Delete temporary files
del /f /s /q %temp%\*

:: Delete files in the recycle bin
rd /s /q C:\$Recycle.bin

:: Delete files in the system temp directory
rd /s /q C:\Windows\Temp\*
pause
::Delete internet browsing history
::Delete Internet Explorer browsing history
runDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8

echo Internet Explorer browsing history deleted successfully!
pause

@echo ///////////////////////////////////////////////////////////////////////////////////////////Windows update
wuauclt /detectnow /updatenow /install
start ms-settings:windowsupdate


@echo //////////////////////////////////////////////////////////////////////////////////////////Remove programs
control appwiz.cpl
pause

@echo /////////////////////////////////////////////////////////////////////////////////////////Network reset
echo Resetting Network...
netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
ipconfig /flushdns
echo Network Reset Completed.
pause

:: Updates
wuauclt /detectnow /updatenow /install

::adjust vidual effects

:: a way to automaticall install all updates and optional updates