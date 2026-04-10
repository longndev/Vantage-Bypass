@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "wt.exe", "cmd /c %~s0", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
)

if "%WT_SESSION%"=="" (
    where wt.exe >nul 2>&1
    if %errorlevel% equ 0 (
        wt.exe cmd /c "%~f0"
        exit /B
    ) else (
        start ms-windows-store://pdp/?ProductId=9n0dx20hk701
        echo [ERROR] Windows Terminal is not installed. Please install it from the Store.
        pause
        exit /B
    )
)

pushd "%cd%"
CD /D "%~dp0"
cls

echo Downloading vantage.py from GitHub...
curl -L -o vantage.py https://raw.githubusercontent.com/longndev/Vantage-Bypass/main/vantage.py

if exist vantage.py (
    echo Starting Vantage...
    python vantage.py
) else (
    echo [ERROR] Failed to download the file. Check your internet connection.
)

echo.
echo Process finished.
pause
