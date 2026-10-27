@echo off
setlocal enabledelayedexpansion
title PlaceTogether Server Launcher

rem ============================================================
rem  PlaceTogether - Universal Server Launcher (ASCII safe)
rem  - server.py is searched ONLY next to this .bat
rem  - Console NEVER closes on error (pause on every path)
rem  - Works with Radmin VPN, Hamachi, LAN, ngrok, Porthole
rem ============================================================

set "PORT=8787"

rem --- Server file: ONLY next to this bat ---------------------
set "SRV=%~dp0server.py"

if not exist "%SRV%" (
    echo.
    echo   ====================================================
    echo    [ERROR] server.py not found
    echo   ====================================================
    echo.
    echo   Expected file:
    echo     %SRV%
    echo.
    echo   Put server.py into the SAME folder as this .bat:
    echo     %~dp0
    echo.
    pause
    exit /b 1
)

rem --- Find Python: PATH, py launcher, portable folder --------
set "PY_CMD="

python --version >nul 2>&1
if not errorlevel 1 set "PY_CMD=python"

if not defined PY_CMD (
    py -3 --version >nul 2>&1
    if not errorlevel 1 set "PY_CMD=py -3"
)

if not defined PY_CMD if exist "%~dp0python_embed\python.exe" (
    set "PY_CMD=%~dp0python_embed\python.exe"
)

if not defined PY_CMD (
    echo.
    echo   ====================================================
    echo    [ERROR] Python not found
    echo   ====================================================
    echo.
    echo   Tried: python, py -3, %~dp0python_embed\python.exe
    echo.
    echo   Install Python 3.10+ from https://www.python.org/downloads/
    echo   and tick "Add python.exe to PATH" during installation.
    echo.
    pause
    exit /b 1
)

rem --- Detect network IPs (errors suppressed) -----------------
set "RADMIN_IP="
set "HAMACHI_IP="
set "LAN_IP="

for /f "usebackq tokens=* delims=" %%a in (`powershell -NoProfile -Command "try { (Get-NetIPAddress -InterfaceAlias '*Radmin*' -AddressFamily IPv4 -ErrorAction Stop | Select-Object -First 1).IPAddress } catch { '' }" 2^>nul`) do set "RADMIN_IP=%%a"

for /f "usebackq tokens=* delims=" %%a in (`powershell -NoProfile -Command "try { (Get-NetIPAddress -InterfaceAlias '*Hamachi*' -AddressFamily IPv4 -ErrorAction Stop | Select-Object -First 1).IPAddress } catch { '' }" 2^>nul`) do set "HAMACHI_IP=%%a"

for /f "usebackq tokens=* delims=" %%a in (`powershell -NoProfile -Command "try { (Get-NetIPAddress -AddressFamily IPv4 -ErrorAction Stop | Where-Object { $_.InterfaceAlias -match 'Ethernet|Wi-Fi' -and $_.IPAddress -notmatch '^127\.' -and $_.IPAddress -notmatch '^169\.254\.' } | Select-Object -First 1).IPAddress } catch { '' }" 2^>nul`) do set "LAN_IP=%%a"

rem --- Try to open firewall port (optional, needs admin) ------
set "FWOK=0"
powershell -NoProfile -Command "try { if (-not (Get-NetFirewallRule -DisplayName 'PlaceTogether %PORT%' -ErrorAction SilentlyContinue)) { New-NetFirewallRule -DisplayName 'PlaceTogether %PORT%' -Direction Inbound -Action Allow -Protocol TCP -LocalPort %PORT% -Profile Any -ErrorAction Stop | Out-Null }; exit 0 } catch { exit 1 }" >nul 2>&1 && set "FWOK=1"

echo.
echo   ====================================================
echo     PlaceTogether Server - ready for co-op
echo   ====================================================
echo.
echo   Python       : !PY_CMD!
echo   Server       : %SRV%
echo   Port         : %PORT%
echo.

if defined RADMIN_IP  echo   [Radmin VPN]  : http://!RADMIN_IP!:%PORT%
if defined HAMACHI_IP echo   [Hamachi]     : http://!HAMACHI_IP!:%PORT%
if defined LAN_IP     echo   [LAN / Wi-Fi] : http://!LAN_IP!:%PORT%
echo   [Localhost]   : http://127.0.0.1:%PORT%
echo.
echo   ----------------------------------------------------
echo   WHAT TO PUT INTO THE ROBLOX STUDIO PLUGIN:
echo   - Radmin VPN users  : copy the [Radmin VPN] address
echo   - Hamachi users     : copy the [Hamachi] address
echo   - ngrok / Porthole  : paste the public tunnel address
echo   - Same PC testing   : http://127.0.0.1:%PORT%
echo   ----------------------------------------------------
echo.

if "%FWOK%"=="0" (
    echo   [i] Firewall rule was NOT created.
    echo       If others cannot connect, run this .bat as Administrator,
    echo       or allow port %PORT% manually in Windows Firewall.
    echo.
)

echo   Server is running. Press Ctrl+C to stop.
echo.

rem --- Data file next to server.py ----------------------------
for %%i in ("%SRV%") do set "SRVDIR=%%~dpi"
set "DATA=%SRVDIR%data.json"

rem --- Run server (pause is guaranteed on any exit path) ------
!PY_CMD! "%SRV%" --port %PORT% --data "%DATA%"
set "EXITCODE=%errorlevel%"

echo.
echo   ====================================================
echo     Server stopped. Exit code: %EXITCODE%
echo   ====================================================
echo.
if not "%EXITCODE%"=="0" (
    echo   The server exited with an error.
    echo   Scroll up to read the Python traceback above.
    echo.
)
pause
endlocal
