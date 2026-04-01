@echo off
:: Script:      install-nvm.cmd
:: Version:     0.3.1 (blackbox)
:: Uso:         install-nvm
:: Descripcion: Crea y descomprime la version noinstall de NVM for Windows en la carpeta AppData/Local/nvm y habilitaremos NVM for Windows y use-node para que puedan ser usados
:: Autor:       Alejandro Delgado Rodríguez (aledero.com)

echo install-nvm v0.3.1 (blackbox)
echo [INFO] Con este script:
echo 1. Habilitamos NVM for Windows
echo 2. Habilitamos use-node
echo 3. Habilitamos git.cmd (para hooks)

:: Obtener ruta de donde instalar nvm (NVM_PARENT_PATH)
set NVM_PARENT_PATH=%USERPROFILE%\AppData\Local
set /p TEMP_NVM_PARENT_PATH="Inserta la ruta donde quieres instalar NVM (se creara la carpeta nvm) (pulsa Intro para ruta recomendada %NVM_PARENT_PATH%): "
if "%TEMP_NVM_PARENT_PATH%"=="" (
    echo [INFO] Usando ruta recomendada...
) else (
    echo [INFO] Usando ruta personalizada...
    set NVM_PARENT_PATH=%TEMP_NVM_PARENT_PATH%
)
set NVM_HOME=%NVM_PARENT_PATH%\nvm
echo [INFO] Ruta definida: %NVM_HOME%


:: Crea carpeta NVM
echo [INFO] Creamos carpeta %NVM_HOME% y movemos el contenido de nvm base...
copy nvm-noinstall-base %NVM_HOME%

:: Mover scripts a carpeta de instalación
echo [INFO] Copiando use-node.cmd a %NVM_HOME%...
copy use-node.cmd %NVM_HOME%
echo [INFO] Copiando git.cmd a %NVM_HOME%...
copy git.cmd %NVM_HOME%

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
