@echo off
setlocal EnableDelayedExpansion
FOR /F "tokens=* usebackq" %%i IN (`MediaInfo.exe %1 --Inform^="Video;%%FrameRate%%"`) do SET VideoFullRate=%%i
for /f "tokens=1,2 delims=." %%a in ('echo %VideoFullRate%') do set VideoIntRate=%%a
for /f "tokens=1" %%a in ('wmic path Win32_VideoController get CurrentRefreshRate ^| FINDSTR [0-9]') do set DefaultRate=%%a
ChangeScreenResolution.exe /f=%VideoIntRate% /d=0
cls
echo Changed monitor refresh to %VideoFullRate%fps and playing video. Don't close this window, it will close itself when video player is closed.
start /wait %1
ChangeScreenResolution.exe /f=%DefaultRate% /d=0
exit