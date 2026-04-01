@echo off
:: Script:      install-nvm.cmd
:: Version:     0.4
:: Uso:         install-nvm
:: Descripcion: Instala NVM for Windows (noinstall) en la carpeta AppData/Local/nvm y habilita NVM for Windows, use-node, use-node-git y use-node-exec para que puedan ser usados
:: Autor:       Alejandro Delgado Rodríguez (aledero.com)

echo install-nvm v0.4
echo [INFO] Con este script:
echo 1. Instalamos version noinstall de NVM for Windows en la ruta especificada (o recomendada)
echo 2. Habilitamos NVM for Windows
echo 3. Habilitamos use-node
echo 4. Habilitamos use-node-git (para hooks)
echo 5. Habilitamos use-node-exec (para ejecutar cualquier comando con node habilitado)

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

:: Crea carpeta NVM copiando nvm-noinstall
echo [INFO] Creamos carpeta %NVM_HOME% y movemos el contenido de nvm base...
copy nvm-noinstall-base %NVM_HOME%

:: Mover scripts a carpeta de instalación
echo [INFO] Copiando use-node.cmd a %NVM_HOME%...
copy use-node.cmd %NVM_HOME%
echo [INFO] Copiando use-node-git.cmd a %NVM_HOME%...
copy use-node-git.cmd %NVM_HOME%
echo [INFO] Copiando use-node-exec.cmd a %NVM_HOME%...
copy use-node-exec.cmd %NVM_HOME%

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
