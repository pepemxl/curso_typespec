# Configuración de Entorno de Trabajo


Tendremos tres opciones para trabajar TypeSpec:

1. Playground [link](https://typespec.io/playground/)
2. Instalar localmente TypeSpec
3. Usar el entorno preconfigurado de este repositorio.


## Playground 

En está sección describiremos como configurar un entorno de trabajo con TypSpec.

Typespec cuenta con un playground que usaremos para familiarizarnos con el lenguage y como principal herramienta de pruebas.

El curso contiene un entorno local el cual está configurado para realizar las practicas de typescript.


---

Consiste normalmente de los siguientes dos pasos:

1. Instalación de Node.js y npm
2. Instalación del compilador TypeSpec

## Requerimientos


Los requirimientos básicos para trabajar con typespec son:

- `node.js 20 LTS`
- `npm 7+`


## Instalando typespec

El primer paso es instalar el compilador de typespec con la siguiente instrucción.

```bash title="Instalación de typespec compiler"
npm install -g @typespec/compiler
```


```bash title="Ejemplo de salida esperada"
added 73 packages in 3s

13 packages are looking for funding
  run `npm fund` for details
npm notice
npm notice New major version of npm available! 10.2.4 -> 11.0.0
npm notice Changelog: https://github.com/npm/cli/releases/tag/v11.0.0
npm notice Run npm install -g npm@11.0.0 to update!
npm notice
```

## Inciar un proyecto de typespec

Ve a directorio donde crearas el proyecto.


## Entorno de trabajo usando este repositorio


Para este repositorio la estructura necesaria para typespec será:

```bash hl_lines="7-9" title="Archivos principales para TypeSpec"
.
├── Dockerfile
├── docker-compose.yml
├── Makefile
├── package.json
├── src/
│   ├── services       # El código de downstream services estará aquí
│   └── main.tsp       # Archivo principal TypeSpec
└── tsp-output/        # Directorio para los archivos generados
```

Nuestro Makefile nos ayudará con los siguientes puntos:

- Desarrollo persistente: Los archivos en `src/` se sincronizan con el contenedor gracias al volumen montado.
- Salida accesible: Los archivos generados se guardan en `tsp-output/` en tu host.
- Dependencias aisladas: El directorio `node_modules` se mantiene persistente pero aislado en un volumen.
- Comandos útiles: El Makefile proporciona atajos para las operaciones comunes.
- Extensible: Podremos añadir más servicios a `docker-compose.yml`.

