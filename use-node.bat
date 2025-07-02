@echo off
:: Script:      use-node.bat
:: Versión:     0.1
:: Uso:         use-node [NODEVERSION]
:: Descripción: Habilita Node.js en la terminal actual con la versión especificada sin admin usando ruta donde se ecuentra el script (ruta de NVM (requerido))
:: Autor:       Alejandro Delgado Rodríguez (aledero.com)

echo use-node v0.1
echo [WARNING] Este script debe estar en la carpeta raiz de NVM for Windows (usando la version noinstall)
echo [INFO] Con este script habilitaremos NodeJS en la version especificada para la terminal actual (requiere NVM)

:: Obtener ruta del script
set SCRIPT_DIR=%~dp0
echo [INFO] Ruta actual del script (carpeta raiz de nvm): %SCRIPT_DIR%

:: Definir version de Node como VERSION
echo [INFO] Definiendo version de Node a usar...
if not "%1"=="" (
    :: Si se le pasa como argumento, la almacenamos en VERSION
    set VERSION=%1
) else (
    :: Si no se pasa versión, intenta leerla desde .nvmrc
    if exist ".nvmrc" (
        for /f "delims=" %%v in (.nvmrc) do (
            echo [INFO] .nvmrc detectado: v%VERSION%
            set VERSION=%%v
        )
    )
)

:: Comprobar si tenemos versión definida
if "%VERSION%"=="" (
    echo [ERROR] No se ha indicado una version de Node como parametro ni declarado un fichero .nvmrc en la ruta actual
    exit /b 1
)
echo [INFO] Version definida v%VERSION%


:: Construir ruta a la versión de Node instalada con la ruta absoluta del script
set NODE_DIR=%SCRIPT_DIR%v%VERSION%

if exist "%NODE_DIR%\node.exe" (
    :: Añadimos NODE_DIR al PATH
    set PATH=%NODE_DIR%;%PATH%
    echo [SUCCESS] Usando Node.js v%VERSION% desde: %NODE_DIR%
    node -v
) else (
    echo [ERROR] La version v%VERSION% no esta instalada en: %NODE_DIR%
    echo [INFO] Puedes instalarla con: nvm install %VERSION%
)