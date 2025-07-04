@echo off
:: Script:      install-nvm.bat
:: Version:     0.2
:: Uso:         install-nvm
:: Descripcion: Crea y descomprime la version noinstall de NVM for Windows en la carpeta AppData/Roaming/nvm y habilitaremos NVM for Windows y use-node para que puedan ser usados
:: Autor:       Alejandro Delgado Rodríguez (aledero.com)

echo install-nvm v0.2
echo [INFO] Con este script:
echo 1. Descomprimimos la version noinstall de NVM for Windows en la ruta especificada (o recomendada)
echo 2. Habilitamos NVM for Windows
echo 3. Habilitamos use-node

:: Obtener ruta de donde instalar nvm (NVM_PARENT_PATH)
set NVM_PARENT_PATH=%USERPROFILE%\AppData\Roaming
set /p TEMP_NVM_PARENT_PATH="Inserta la ruta donde quieres instalar NVM (se creara la carpeta nvm) (pulsa Intro para ruta recomendada %NVM_PARENT_PATH%): "
if "%TEMP_NVM_PARENT_PATH%"=="" (
    echo [INFO] Usando ruta recomendada...
) else (
    echo [INFO] Usando ruta personalizada...
    set NVM_PARENT_PATH=%TEMP_NVM_PARENT_PATH%
)
set NVM_HOME=%NVM_PARENT_PATH%\nvm
echo [INFO] Ruta definida: %NVM_HOME%

:: Descomprime NVM
echo [INFO] Descomprimiendo nvm-noinstall con 7Zip en la carpeta %NVM_HOME%...
"C:\Program Files\7-Zip\7z.exe" e nvm-noinstall.zip -o%NVM_HOME%

:: Mover scripts a carpeta de instalación
echo [INFO] Copiando use-node.bat a %NVM_HOME%...
copy use-node.bat %NVM_HOME%

:: Detectar carpeta actual como base para SYMLINK (donde está NVM)
set NVM_SYMLINK=%NVM_HOME%\nodejs

:: Obtener arquitectura del procesador
echo [INFO] Definimos la aquitectura del procesador...
if "%PROCESSOR_ARCHITECTURE%"=="X86" (
    set ARCH=32
) else (
    set ARCH=64
)
echo [INFO] Arquitectura definida como %ARCH% bits

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

echo [INFO] Instalacion completada!
