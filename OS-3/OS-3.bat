@echo off
SetLocal EnableExtensions

Call :GetSystemVersion "OSVer" "Core" "Build"
Echo Your operating system: %OSVer% %Core% %Build%

pause
goto :eof

:GetSystemVersion
:: Определить версию ОС
:: %1-исх.Переменная для хранения названия ОС
:: %2-исх.Переменная для хранения разрядности ОС
:: %3-исх.Переменная для хранения версии сборки ОС
Set "Bitness=x64"& If "%PROCESSOR_ARCHITECTURE%"=="x86" If Not Defined PROCESSOR_ARCHITEW6432 Set "Bitness=x32"
set "%~2=%Bitness%"
For /F "delims=" %%a in ('ver') do set _ver=%%a
Set _ver="%_ver: =" "%"
For %%a in (%_ver%) do set _ver=%%~a
for /F "delims=]" %%a in ("%_ver%") do set %~3=%%a
set _ver=%_ver:~0,3%
SET %~1=Unknown
if "%_ver%"=="5.0" SET %~1=Windows 2000
if "%_ver%"=="5.1" SET %~1=Windows XP
if "%_ver%"=="5.2" if "%Bitness%"=="x64" (SET %~1=Windows XP) else (SET %~1=Windows 2003)
if "%_ver%"=="6.0" (
Reg.exe query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "ProductName"|>nul Find /i "Vista"&&(
SET %~1=Windows Vista) || (SET %~1=Windows 2008)
)
if "%_ver%"=="6.1" SET %~1=Windows 7
if "%_ver%"=="6.2" SET %~1=Windows 8
if "%_ver%"=="6.3" SET %~1=Windows 8.1
if "%_ver%"=="6.4" SET %~1=Windows 10
if "%_ver%"=="10." SET %~1=Windows 10
set _ver=
Exit /B