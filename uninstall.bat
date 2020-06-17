@echo off
cls
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    goto begin 
) ELSE (
    ECHO Please run this file as administrator!
pause
exit
)
:begin
echo This will remove NativeFPS from your system, INCLUDING external tools (see README.md).
:question 
   set /p answer=Do you really want to continue (Y/N)?
   if /i "%answer:~,1%" EQU "Y" goto uninstall
   if /i "%answer:~,1%" EQU "N" goto keep
   echo Please type Y for Yes or N for No
   goto question
:keep
Uninstall canceled. You can keep using NativeFPS :D
pause
exit
:uninstall
echo Removing registry entries...
reg delete "HKCR\*\shell\Open in Native FPS" /f
echo Deleting files...
del "%PROGRAMFILES%\NativeFPS\NativeFPS.bat" /f
del "%PROGRAMFILES%\NativeFPS\MediaInfo.exe" /f
del "%PROGRAMFILES%\NativeFPS\ChangeScreenResolution.exe" /f
echo Finished deleting software. Continue to self-destruct uninstaller and exit.
pause
(goto) 2>nul & rmdir /s /q "%PROGRAMFILES%\NativeFPS\"
exit
