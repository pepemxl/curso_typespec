# Configuración del Entorno

Consiste normalmente de los siguientes dos pasos:

1. Instalación de Node.js y npm
2. Instalación del compilador TypeSpec

## Requerimientos


- `node.js 20 LTS`
- `npm 7+`


## Instalando typespec

`npm install -g @typespec/compiler`


```bash
npm install -g @typespec/compiler

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

```bash
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

