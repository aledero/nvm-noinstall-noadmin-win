@echo off
:: Script:      use-node.bat
:: Versión:     0.2
:: Uso:         use-node [NODEVERSION]
:: Descripción: Habilita Node.js en la terminal actual con la versión especificada sin admin usando ruta donde se ecuentra el script (ruta de NVM (requerido))
:: Autor:       Alejandro Delgado Rodríguez (aledero.com)

echo use-node v0.2
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
            echo [INFO] .nvmrc detectado: v%%v
            set VERSION=%%v
        )
    )
)

:: Comprobar si tenemos versión definida
if "%VERSION%"=="" (
    echo [ERROR] No se ha indicado una version de Node como parametro ni declarado un fichero .nvmrc en la ruta actual
    exit /b 1
)
echo [INFO] Version a usar definida: v%VERSION%

:: Comprobar si ya tenemos node activo en esa version
goto checkNode

:checkNode
echo [INFO] Comprobando version en uso de node...

@echo off
for /f "delims=" %%a in ('node -v 2^>nul') do set "NODE_NEW_VERSION=%%a"
if "%NODE_NEW_VERSION%"=="v%VERSION%" (
	:: Node ya está activo en la version concreta
	echo [SUCCESS] Node activado en la version %NODE_NEW_VERSION%
	exit /b 0
) else (
	:: Construir ruta a la versión de Node instalada con la ruta absoluta del script
	set NODE_DIR=%SCRIPT_DIR%v%VERSION%

	goto searchForNode
)

:useVersion
set PATH=%NODE_DIR%;%PATH%
echo [INFO] Usando Node.js v%VERSION% desde: %NODE_DIR%

goto checkNode

:: Buscar ejecutables de node
:searchForNode
echo [INFO] Buscando ejecutables de node...
if exist "%NODE_DIR%\node.exe" (
    :: Añadimos NODE_DIR al PATH
	echo [INFO] Encontrado: %NODE_DIR%\node.exe
    set PATH=%NODE_DIR%;%PATH%
	
	goto checkNode
) else if exist "%NODE_DIR%\node64.exe" (
	:: Añadimos NODE_DIR al PATH
	echo [INFO] Encontrado: %NODE_DIR%\node64.exe
	set PATH=%NODE_DIR%;%PATH%
	
	:: Creamos fichero node.exe para usar comando node
	echo [INFO] Creando fichero node.exe para poder usar comando node...
	copy "%NODE_DIR%\node64.exe" "%NODE_DIR%\node.exe"
	
	goto checkNode
) else (
	:: Mostramos error e instalamos
	echo [ERROR] La version v%VERSION% no esta instalada en: %NODE_DIR%
	echo [INFO] Vamos a proceder a instalar esa version de node. Si no quieres, termina la ejecucion.
	echo Pulse cualquier tecla para continuar con la instalacion...
	pause>nul
	echo [INFO] Instalando...
	call nvm install %VERSION%
	
	goto searchForNode
)
