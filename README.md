# nvm-noinstall-noadmin-win

NVM NoIntsall NoAdmin Windows (NVM for Windows sin Privilegios de Administrador)

- Licencia: MIT License
- Versión: 0.4
- Autor: Alejandro Delgado Rodríguez (aledero.com)

Este script permite instalar y gestionar múltiples versiones de Node.js en Windows sin necesidad de permisos de administrador, ideal para entornos corporativos donde no se puede usar `nvm-windows` por restricciones del sistema.

## 🚀 Características

- Descarga y cambia entre versiones de NodeJS con NVM for Windows
- Uso completamente desde CMD
- No requiere permisos de administrador
- No requiere 7zip
- Ideal para trabajar con varios proyectos simultáneamente
- No requiere instalación

## 📦 Instrucciones de instalación y uso

Con este metodo, Node y NPM no estarán instalados en el equipo pero se podrán usar temporalmente donde sea habilitado.

### Preparación del entorno (VV = versión)

1. Descargamos la última versión de los scripts en formato ZIP (`nvm-noinstall-noadmin-win-VV.zip`)
2. Descomprimimos el zip en una nueva carpeta (`nvm-noinstall-noadmin-win-VV`)
3. Ya estamos listos para instalar

**IMPORTANTE**: Al haber sido descargado de internet, es probable que te salte una advertencia de Windows SmartScreen sobre que el fichero puede ser peligroso. Puedes evitarlo en Propiedades > Desbloquear o simplemente dándole a Más Información > Ejecutar de todas formas. Siempre que se haya descargado de este repo, el fichero es totalmente seguro.

### Instalación de NVM for Windows (versión noinstall) (VV = versión)

1. En una carpeta `nvm-noinstall-noadmin-win-VV` debemos de tener:
   - nvm-noinstall-base
     - elevate.cmd
     - elevate.vbs
     - install.cmd
     - nodejs.ico
     - nvm.exe
     - setuserenv.vbs
     - unsetuserenv.vbs
   - install-nvm.cmd
   - use-node.cmd
   - use-node-git.cmd
   - use-node-exec.cmd
2. Ejecutamos, por cmd o con doble click el script `install-nvm.cmd`
3. Preguntará por la ruta de instalación. Recomiendo no introducir nada y que siga con la recomendada (`UserAppData\Local\nvm`)
4. Al finalizar, te creará un fichero `LEEME.txt` en la carpeta de instalación de NVM. Ábrelo y crea esas 2 variables de entorno de usuario de Windows (NVM_HOME y NVM_SYMLINK) y añádelas al PATH de esta forma: %NVM_HOME%;%NVM_SYMLINK%
5. Pulsa cualquier tecla para cerrar el script y listo.

Ya podrás usar los comandos nvm, use-node, use-node-git y use-node-exec

### Instala las versiones que necesites de Node con NVM

1. Ejecuta `nvm install VERSION` escribiendo la que quieras
2. Listo.

### Usa Node y NPM en una terminal (especificando versión)

1. Ejecuta `use-node VERSION` en la terminal para habilitar node en esa terminal
2. En el caso en que no esté instalada la versión deseada, te preguntará si quieres instalarlo
3. Ya puedes usar node y npm

### Usa Node y NPM en una terminal con .nvmrc (usando el fichero .nvmrc de la raíz de un proyecto)

1. Posicionate en la raiz del proyecto que contenga el fichero `.nvmrc`
2. Ejecuta `use-node` en la terminal para habilitar node en esa terminal
3. En el caso en que no esté instalada la versión deseada, te preguntará si quieres instalarlo
4. Ya puedes usar node y npm

### Usa Node y NPM en git con .nvmrc (usando el fichero .nvmrc de la raíz de un proyecto)

1. Posicionate en la raiz del proyecto que contenga el fichero `.nvmrc`
2. Ejecuta `use-node-git status/pull/push/...` en la terminal para habilitar node y ejecutar un comando de git
3. En el caso en que no esté instalada la versión deseada, te saldrá un error y te dirá de instalarlo usando `use-node`

### Usa Node y NPM con cualquier comando con .nvmrc (usando el fichero .nvmrc de la raíz de un proyecto) (blackbox)

1. Posicionate en la raiz del proyecto que contenga el fichero `.nvmrc`
2. Ejecuta `use-node-exec ANYCOMMAND` en la terminal para habilitar node y ejecutar un comando de cmd
3. En el caso en que no esté instalada la versión deseada, te saldrá un error y te dirá de instalarlo usando `use-node`

### Fichero .nvmrc

Para que detecte automáticamente la versión de NodeJS que quieras usar en el repo, añade un fichero `.nvmrc` con la versión como contenido. Por Ejemplo:

```bash
22.17.0
```

Incluso puedes poner una major version y se te descargará la más reciente

```bash
22
```

#### Recuerda que cada vez que quieras usar node o npm en una terminal tendrás que ejecutar use-node para habilitarlos

## Creditos

La carpeta `nvm-noinstall-base` contiene el programa nvm-install con licencia MIT (https://github.com/coreybutler/nvm-windows) especificamente la versión 1.1.12 (https://github.com/coreybutler/nvm-windows/releases/tag/1.1.12). Licencia incluida en la misma carpeta.
