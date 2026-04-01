@echo off

:: use-node-exec v0.4
:: This enables node for any cmd command!

:: Search and set defined VERSION
set SCRIPT_DIR=%~dp0
if exist ".nvmrc" (
    for /f "delims=" %%v in (.nvmrc) do (
        :: Check if version is defined
        if %%v == "" (
            :: Node version not found. This could mean that we don't need node here, lets continue!
            goto continueExec
        )
	    :: Set defined VERSION
        set VERSION=%%v
    )
) else (
    :: No .nvmrc file found. This could mean that we don't need node here, lets continue!
    goto continueExec
)

:: Check if major version defined
echo %VERSION% | findstr "\." >nul
if %ERRORLEVEL%==0 (
	:: Not a major version
	set VERSION=v%VERSION%
	set PATH=%SCRIPT_DIR%%VERSION%;%PATH%
	goto continueExec
) else (
	:: It's a major version
	goto resolveMajor
)

:resolveMajor
for /f "delims=" %%d in ('dir /b /ad "%SCRIPT_DIR%v%VERSION%.*" 2^>nul') do set "RESOLVED_VERSION=%%d"

if "%RESOLVED_VERSION%"=="" (
    :: Not installed, fail
	set VERSION=%RESOLVED_VERSION%
	goto nodeNotInstalled
) else (
	:: Version installed
    set VERSION=%RESOLVED_VERSION%
	set PATH=%SCRIPT_DIR%%VERSION%;%PATH%
    goto continueExec
)

:searchForNode
:: Add NODE_DIR to PATH
set PATH=%NODE_DIR%;%PATH%
goto continueExec

:nodeNotInstalled
echo [ERROR] NODE v%VERSION% NOT INSTALLED!
exit /b 1

:continueExec
:: Execute command with node enabled
%*
