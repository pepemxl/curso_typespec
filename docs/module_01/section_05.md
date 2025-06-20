# Ejercicio práctico

- Crear un archivo `.tsp` básico
- Definir un modelo simple y compilarlo



```bash

```


## Proyecto REST API Generico

```bash title="example_02: Iniciar Proyecto"
tsp init
```

```bash title="example_02: Generic REST API"
TypeSpec compiler v0.64.0

? Please select a template › - Use arrow-keys. Return to submit.
    Empty project       min compiler ver: 0.64.0
❯   Generic REST API    min compiler ver: 0.64.0 - Create a project representing a generic REST API
    TypeSpec Library (With TypeScript)  min compiler ver: 0.64.0
    TypeSpec Emitter (With TypeScript)  min compiler ver: 0.64.0
```

- Asignar nombre: por defecto nombre del folder
- Agregar o no `.gitignore` file
- Opcines de `Generic REST API`
    - http
    - rest
    - openapi3

```bash title="example_02: Siguientes pasos"
TypeSpec compiler v0.64.0

✔ Please select a template › Generic REST API   min compiler ver: 0.64.0
Create a project representing a generic REST API
✔ Project name … example_02
✔ Do you want to generate a .gitignore file? … no
? Update the libraries? ›  
Instructions:
    ↑/↓: Highlight option
    ←/→/[space]: Toggle selection
    a: Toggle all
    enter/return: Complete answer
◉   @typespec/http
◉   @typespec/rest
◉   @typespec/openapi3
```

Al seleccionar `http`:

```bash title="salida"
TypeSpec compiler v0.64.0

✔ Please select a template › Generic REST API   min compiler ver: 0.64.0
Create a project representing a generic REST API
✔ Project name … example_02
✔ Do you want to generate a .gitignore file? … no
✔ Update the libraries? › @typespec/http, @typespec/rest, @typespec/openapi3

TypeSpec init completed. You can run `tsp install` now to install dependencies.
Project created successfully.
```

Genera los siguientes tres archivos: `main.tsp`, `package.json`, `tspconfig.yaml`.

```bash title="main.tsp"
import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
```

```bash title="package.json"
{
  "name": "example_02",
  "version": "0.1.0",
  "type": "module",
  "peerDependencies": {
    "@typespec/compiler": "latest",
    "@typespec/http": "latest",
    "@typespec/rest": "latest",
    "@typespec/openapi3": "latest"
  },
  "devDependencies": {
    "@typespec/compiler": "latest",
    "@typespec/http": "latest",
    "@typespec/rest": "latest",
    "@typespec/openapi3": "latest"
  },
  "private": true
}
```

```bash title="tspconfig.yaml"
emit:
  - "@typespec/openapi3"
```

Al usar el comando `tsp install`, todas las dependencias necesarias serán instaladas.

```bash title="tsp install"
TypeSpec compiler v0.64.0


added 114 packages, and audited 115 packages in 9s

21 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
```

