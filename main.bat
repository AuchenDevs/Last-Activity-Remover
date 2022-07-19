@echo off
title Last Activity View deleter ^| By AuchenDevs


:main
echo.
echo.
echo [1]. Delete
echo.
echo [2]. Exit
echo.
echo.
set /p opc=Option: 
if "%opc%"=="1" goto delete
if "%opc%"=="1" del %~f0


echo No valid option selected!
timeout 2 /nobreak >nul
goto main

:delete


::Logon... reg
for /F  %%a in ('wevtutil.exe el') do (wevtutil.exe cl "%%a" && set totalev+=1)

::Delete "View Folder in Explorer"
reg delete "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\BagMRU" /f
reg add "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\BagMRU" /f 

::Delete MUICache (Thats for muicache viewer but anyways)
reg delete "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" /f
reg add "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" /f 

::Delete prefetch the last one for hide all
takeown /f C:\Windows\Prefetch /r /d s
for /f %%a in ('dir C:\Windows\Prefetch /b') do (del /f /s /q C:\Windows\Prefetch\%%a && set /a totalp+=1)
goto main