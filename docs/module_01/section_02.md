# ¿Qué es TypeSpec?


[Typespec Docs](https://typespec.io/docs/)


TypeSpec es un lenguaje de definición/descripción de API desarrollado por Microsoft, el cual es agnostico a los lenguages de programación (DSL). Diseñado especialmente para crear APIs, en principio esto es posible a partir del diseño de la data de nuestros servicios.

Al ser una asbtracción de OpenAPI nos permite especificar componentes importantes de una API, cosas como:

- Visibillidad
- Autorización
- Dominios
    - Modelos
    - Campos(Fields)
    - Joins
- Filtrado
- Errores

<h2>El flujo de trabajo con TypeSpec</h2>


![FlujoTypeSpec](../images/flujo_typespec.png)


Sus características clave:

- Descripción de APIs: TypeSpec permite definir la forma de las APIs (Application Programming Interfaces), incluyendo sus entradas, salidas y comportamientos.
- Generación de código: A partir de las definiciones en TypeSpec, se puede generar automáticamente código para diferentes propósitos:
    - Clientes: Código para que otros sistemas interactúen con la API.
    - Servidores: Código para implementar la lógica de la API.
    - Documentación: Documentación clara y concisa de la API.
- Multi-protocolo: TypeSpec es compatible con diversos protocolos de comunicación, como REST, gRPC y otros.
- Extensible: Es un lenguaje altamente extensible que permite crear patrones y bibliotecas reutilizables para diferentes aspectos de las APIs.
- Linter integrado: Incluye un sistema de linter que ayuda a detectar posibles problemas y anti-patrones en las definiciones de API.


## Ventajas sobre OpenAPI/Swagger

TypeSpec ofrece varias ventajas significativas sobre OpenAPI/Swagger, especialmente en escenarios de desarrollo moderno y a gran escala. 

Es un Domain Specific Language (DSL), es decir, es un lenguage con sintaxis concisa y capacidades de abstracción.

### Modelos, Operaciones y Relaciones

Permite definir modelos, operaciones y relaciones con tipos fuertes, herencia, genéricos y decoradores.

Por ejemplo:

#### TypeSpec

```yaml title="Endpoint User" linenums="1"
@route("/users")        # Path
namespace Users {       # Namespace
  model User {          # Model
    @key id: string;    # Field
    name: string;       # Field
    age: int32;         # Field
  }

  op list(): User[];    # Operation
}
```
```yaml title="Endpoin User" linenums="1"
import "@typespec/http";

using Http;

@service               # Service
namespace Users {      # Namespace
  @route("/users")     # Path
  op list(): User[];   # Operation

  model User {         # Model
    @key id: string;   # Field
    name: string;      # Field
    age: int32;        # Field
  }
}
```




Esto describe un endpoint con las siguientes caracteristicas:

- Ruta (URL): `/users`
- Método HTTP: `GET` (implícito por la operación `list`)
- Namespace: `Users`
- Operación: `list()`
- Respuesta: Un array de objetos `User`


Mientras que en OpenAPI/Swagger se vería como:

#### OpenAPI/Swagger

```yaml title="Endpoint User" linenums="1"
paths:
  /users:
    get:
      responses:
        200:
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: "#/components/schemas/User"
components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
        name:
          type: string
        age:
          type: integer
          format: int32
      required: [id, name, age]
```


### Modularidad

Typespec soporta modularidad  a travez de namespaces, imports y templates. También permite extender modelos con `extends` o `mixins`.

Ejemplo:

```yaml title="User como Extension de Timestamp"
model Timestamps {
  createdAt: zonedDateTime;
  updatedAt: zonedDateTime;
}

model User extends Timestamps {
  id: string;
}
```

### Decoradores

Typespec usa decoradores para añadir metadatos específicos. (ej: `@route`, `@body`, `@doc`). 

Sin embargo tambien podemos crear decoradores custom para nuestros casos de uso.

Ejemplo:

```yaml title="Decorador doc" linenums="1"
@doc("Usuario del sistema")
model User {
  @minLength(3)
  name: string;
}
```

### Emitters

Typespec usa emitter para crear código específico y además permite crear versiones customizadas a nuestras necesidades que será nuestro principal objetivo en este curso.

- TypeSpec--> OpenAPI
- TypeSpec --> OpenAPI + Clases Python + Client SDK.

### Validación de Tipos

- Tiene un sistema de tipos avanzado (uniones, genéricos, templates).
- Detecta errores en tiempo de compilación.

Ejemplo:

```yaml
op getUser(id: string): User | Error;
```

## La Arquitectura de TypeSpec

El eje central de typespec es el `compiler`, sin embargo para los usuarios de typespec nuestro principal atención será alrededor de `Emitters`. Más adelante profundizaremos en los elementos de typespec para poder extender y customizar nuestras implementaciones.


![ArquitecturaTypeSpec](../images/arquitectura_de_typespec.png)



## Plugin para Visual Studio Code

<div>
<a href="https://marketplace.visualstudio.com/items?itemName=typespec.typespec-vscode">Link a Plugin de VSCODE</a>
</div>

