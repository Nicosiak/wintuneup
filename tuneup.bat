@echo off

@echo off
color 0a
echo  _____ ____  _   _ 
echo |  ___|  _ \| | | |
echo | |_  | |_l | | | |
echo |  _| |  __/| |_| |
echo |_|   |_|    \___/ 


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

The powercfg command is a tool in Windows that allows you to manage the power settings of your system. Here are some common powercfg commands that you can use in the Command Prompt:

powercfg /list: Lists all the power plans on your system.
powercfg /setactive <GUID>: Sets the specified power plan as the active plan. Replace <GUID> with the GUID of the power plan you want to activate.
powercfg /query <GUID>: Displays detailed information about the specified power plan. Replace <GUID> with the GUID of the power plan you want to view.
powercfg /hibernate on: Enables hibernation on your system.
powercfg /hibernate off: Disables hibernation on your system.
powercfg /devicequery wake_armed: Lists all the devices that are allowed to wake the system from sleep.
powercfg /deviceenablewake <device ID>: Enables the specified device to wake the system from sleep. Replace <device ID> with the ID of the device you want to enable.
powercfg /devicedisablewake <device ID>: Disables the specified device from waking the system from sleep. Replace <device ID> with the ID of the device you want to disable.

encrypt with a program put both programs on a flash drive and use same program to unencrypt
