# nvm-noinstall-noadmin-win

NVM NoIntsall NoAdmin Windows (NVM for Windows sin Privilegios de Administrador)

- Licencia: MIT License
- Versión: 0.2
- Autor: Alejandro Delgado Rodríguez (aledero.com)

Este script permite instalar y gestionar múltiples versiones de Node.js en Windows sin necesidad de permisos de administrador, ideal para entornos corporativos donde no se puede usar `nvm-windows` por restricciones del sistema.

## 🚀 Características

- Descarga y cambia entre versiones de NodeJS con NVM for Windows
- Uso completamente desde CMD
- No requiere permisos de administrador
- Ideal para trabajar con varios proyectos simultáneamente
- No requiere instalación

## 📦 Instrucciones de instalación y uso

Con este metodo, Node y NPM no estarán instalados en el equipo pero se podrán usar temporalmente donde sea habilitado.

### Preparación del entorno

1. Descargamos la última versión de los scripts en formato ZIP (`nvm-noinstall-noadmin-win-latest.zip`)
2. Descomprimimos el zip y veremos una nueva carpeta (`nvm-noinstall-noadmin-win-latest`)
3. Descargamos la versión deseada de NVM for Windows en formato noinstall desde el repo oficial https://github.com/coreybutler/nvm-windows
   - Recomiendo la version 1.1.12
   - Las descargas se encuentran en la parte de Releases: https://github.com/coreybutler/nvm-windows/releases/tag/1.1.12
   - Descarga el zip `nvm-noinstall.zip`
4. Movemos `nvm-noinstall.zip` a la carpeta `nvm-noinstall-noadmin-win-latest`
5. Ya estamos listos para instalar

### Instalación de NVM for Windows (versión noinstall)

1. En una carpeta debemos de tener:
   - nvm-noinstall.zip
   - install-nvm.bat
   - use-node.bat
2. Ejecutamos, por cmd o con doble click el script `install-nvm.bat`
3. Preguntará por la ruta de instalación. Recomiendo no introducir nada y que siga con la recomendada (`UserAppData\Roaming\nvm`)
4. Al finalizar, te creará un fichero `LEEME.txt` en la carpeta de instalación de NVM. Ábrelo y crea esas 2 variables de entorno de usuario de Windows (NVM_HOME y NVM_SYMLINK) y añádelas al PATH de esta forma: %NVM_HOME%;%NVM_SYMLINK%
5. Pulsa cualquier tecla para cerrar el script y listo.

Ya podrás usar los comandos nvm y use-node

### Usa Node y NPM en una terminal (especificando versión)

1. Ejecuta `use-node VERSION` en la terminal para habilitar node en esa terminal
2. En el caso en que no esté instalada la versión deseada, te preguntará si quieres instalarlo
3. Ya puedes usar node y npm

### Usa Node y NPM en una terminal con .nvmrc (usando el fichero .nvmrc de la raíz de un proyecto)

1. Posicionate en la raiz del proyecto que contenga el fichero `.nvmrc`
2. Ejecuta `use-node` en la terminal para habilitar node en esa terminal
3. En el caso en que no esté instalada la versión deseada, te preguntará si quieres instalarlo
4. Ya puedes usar node y npm

### Fichero .nvmrc

Para que detecte automáticamente la versión de NodeJS que quieras usar en el repo, añade un fichero `.nvmrc` con la versión como contenido. Por Ejemplo:

```bash
22.17.0
```

#### Recuerda que cada vez que quieras usar node o npm en una terminal tendrás que ejecutar use-node para habilitarlos
