@echo off
:: Script:      install-nvm.bat
:: Version:     0.1
:: Uso:         install-nvm
:: Descripcion: Crea y descomprime la version noinstall de NVM for Windows en la carpeta AppData/Roaming/nvm
:: Autor:       Alejandro Delgado Rodríguez (aledero.com)

echo install-nvm v0.1
echo [INFO] Con este script descomprimos la version noinstall de NVM for Windows en la ruta especificada (o recomendada) y movemos los scripts necesarios

:: Obtener ruta de donde instalar nvm (NVM_PATH)
set NVM_PATH=%USERPROFILE%\AppData\Roaming
set /p TEMP_NVM_PATH="Inserta la ruta donde quieres instalar NVM (se creara la carpeta nvm) (pulsa Intro para ruta recomendada %NVM_PATH%): "
if "%TEMP_NVM_PATH%"=="" (
    echo [INFO] Usando ruta recomendada:
) else (
    echo [INFO] Usando ruta personalizada:
    set NVM_PATH=%TEMP_NVM_PATH%
)
echo %NVM_PATH%\nvm

:: Descomprime NVM
echo [INFO] Descomprimiendo con 7Zip...
"C:\Program Files\7-Zip\7z.exe" e nvm-noinstall.zip -o%NVM_PATH%\nvm

:: Mover scripts a carpeta de instalación
echo [INFO] Moviendo scripts a %NVM_PATH%\nvm...
move prepare-nvm.bat %NVM_PATH%\nvm
move use-node.bat %NVM_PATH%\nvm

echo Pulsa cualquier tecla para continuar la instalacion ejecutando prepare-nvm.bat...
pause>nul
cls
%NVM_PATH%\nvm\prepare-nvm.bat
