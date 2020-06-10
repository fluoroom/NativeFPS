@echo off
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    goto begin 
) ELSE (
    ECHO Please run this file as administrator!
pause
exit
)
:begin
echo This will install NativeFPS in %PROGRAMFILES%\NativeFPS, add a registry entry for the context menu and add the program's folder to PATH.
echo Files to install:
echo README.txt
echo NativeOpen.bat
echo MediaInfo.exe (see README.md)
echo ChangeScreenResolution.exe (see README.md)
echo WARNING: Already existing files in %PROGRAMFILES%\NativeFPS (if any) will be overwritten. Please backup if necessary.
:question 
   set /p answer=Do you want to install (Y/N)?
   if /i "%answer:~,1%" EQU "Y" goto install
   if /i "%answer:~,1%" EQU "N" goto noinstall
   echo Please type Y for Yes or N for No
   goto question
:noinstall
Installation canceled :(
pause
exit
:install
echo Creating %PROGRAMFILES%\NativeFPS directory...
if not exist "%PROGRAMFILES%\NativeFPS" mkdir "%PROGRAMFILES%\NativeFPS"
echo Moving files...
copy "%~dp0\NativeFPS.bat" "%PROGRAMFILES%\NativeFPS\NativeFPS.bat" /y
copy "%~dp0\MediaInfo.exe" "%PROGRAMFILES%\NativeFPS\MediaInfo.exe" /y
copy "%~dp0\ChangeScreenResolution.exe" "%PROGRAMFILES%\NativeFPS\ChangeScreenResolution.exe" /y
echo Adding registry entry...
reg add "HKCR\*\shell\Open in Native FPS\command" /ve /t REG_SZ /d "%PROGRAMFILES%\NativeFPS\NativeFPS.bat %%1" /f
echo Adding program folder to PATH...
setx path "%path%;%PROGRAMFILES%\NativeFPS"
echo Install successful :D
echo You may need to restart or sign out to see changes.
pause
exit
