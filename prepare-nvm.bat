@echo off
:: Script:      prepare-nvm.bat
:: Versión:     0.1
:: Uso:         prepare-nvm
:: Descripción: Prepara NVM para poder ser usado. Debe colocarse en la ruta raiz donde se ecuentra NVM
:: Autor:       Alejandro Delgado Rodríguez (aledero.com)

echo prepare-nvm v0.1
echo [WARNING] Este script debe estar en la carpeta raiz de NVM for Windows (usando la version noinstall)
echo [INFO] Con este script habilitaremos NVM for Windows para poder ser usado

:: Obtener ruta del script (NVM_HOME)
set CURRENT_PATH=%~dp0
set NVM_HOME=%CURRENT_PATH:~0,-1%%
echo [INFO] Ruta actual del script (carpeta raiz de nvm): %NVM_HOME%

:: Detectar carpeta actual como base para SYMLINK (donde está NVM)
set NVM_SYMLINK=%NVM_HOME%\nodejs

:: Obtener arquitectura del procesador
if "%PROCESSOR_ARCHITECTURE%"=="X86" (
    set ARCH=32
) else (
    set ARCH=64
)

:: Crear o sobreescribir settings.txt
echo [INFO] Escribiendo settings.txt...
(
    echo arch: %ARCH%
    echo path: %NVM_SYMLINK%
    echo proxy: none
    echo root: %NVM_HOME%
) > "%NVM_HOME%\settings.txt"
echo [SUCCESS] Fichero settings creado

:: Definir variables de entorno de usuario (persistentes)
echo [WARNING] Para terminar la instalacion, abre el fichero LEEME.txt creado en la carpeta raiz de NVM y sigue las instrucciones
(
    echo Crea 2 variables de entorno de usuario:
	echo NVM_HOME: %NVM_HOME%
	echo NVM_SYMLINK: %NVM_SYMLINK%
	echo.
	echo Mete las variables a PATH usando el simbolo porcentaje antes y despues de cada variable.
) > "%NVM_HOME%\LEEME.txt"

echo Pulse cualquier tecla para abrir el fichero LEEME.txt...
pause>nul
call notepad %NVM_HOME%\LEEME.txt

echo Pulse cualquier tecla para salir...
pause>nul