@echo off

:: use-node-git v0.3.1 (blackbox)
:: This enables node when using git!

:: Search and set defined VERSION
set SCRIPT_DIR=%~dp0
for /f "delims=" %%v in (.nvmrc) do (
	:: Set defined VERSION
	set VERSION=%%v
)

:: Check if version is defined
if "%VERSION%"=="" (
    :: Node version not found. This could mean that we don't need node here, lets continue using git
    goto continueGit
)

:: Check if major version defined
echo %VERSION% | findstr "\." >nul
if %ERRORLEVEL%==0 (
	:: Not a major version
	set VERSION=v%VERSION%
	set PATH=%SCRIPT_DIR%%VERSION%;%PATH%
	goto continueGit
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
    goto continueGit
)

:searchForNode
    :: Add NODE_DIR to PATH
    set PATH=%NODE_DIR%;%PATH%
	goto continueGit
:nodeNotInstalled
echo [ERROR] NODE v%VERSION% NOT INSTALLED! EXECUTE use-node ONCE BEFORE USING git.cmd
exit /b 1

:continueGit
:: Execute git command with node enabled
git %*
