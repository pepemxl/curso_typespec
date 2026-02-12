# Sintaxis básica

## Sintaxis Básica

Puedes checar toda la sintaxis en el sitio [https://typespec.io/docs/language-basics/overview/](https://typespec.io/docs/language-basics/overview/)

vamos a revisar parte de la sintaxis básica que nos permitira trabajar en los proyectos.

## Aliases

Los alias son una forma práctica de definir abreviaturas para tipos, especialmente al trabajar con expresiones complejas. Simplifican la sintaxis, pero no se representan en el grafo de tipos. Por lo tanto, no se pueden decorar. Si necesita asignar un nombre alternativo a un modelo se utiliza `model is`.

Podemos definir un alias con la palabra clave `alias`.

```ts
alias Options = "one" | "two";
```

```ts
alias UserName = User.name;
```

## Declaración de variables(Identifiers)

Un variable o identificador es una secuencia de uno o más caracteres que debe comenzar con una letra, un emoji, un guion bajo o un signo de dólar, y ser seguido por letras, números, emojis, guiones bajos o signos de dólar.

La declariación de variables(Identifiers) debe ser única dentro del mismo scope.

```yaml title="No permitido"
namespace User {};
model User {};
```

```bash title="Salida de Error"
error duplicate-symbol Duplicate name: "User" 1:1
error duplicate-symbol Duplicate name: "User" 2:1
```

Así que tenemos que ser muy consientes del diseño, sin embargo, al mismo tiempo podemos  visualizar errores durante el diseño.


Ejemplos de nombres validos e invalidos:

- ✅ cat
- ✅ Dog
- ✅ _Item2
- ✅ $money$
- ✅ 🎉
- ✅ 🚀
- ❌ 1cat
- ❌ *dog

Como en todo lenguaje tenemos palabras reservadas, sin embargo podemos utilzarlas simplemente escapandolas con un apostrofe reverso `` ` `` .

```yaml title="example"
model `enum` {};
```


## Decoradores Comunes

Los decoradores en TypeSpec nos permiten adjuntar metadatos a los tipos dentro de un programa TypeSpec. También se pueden usar para calcular tipos a partir de sus entradas. Los decoradores constituyen la base de la extensibilidad de TypeSpec, proporcionando la flexibilidad para describir una amplia variedad de API y metadatos asociados, como documentación, restricciones, ejemplos y más.

Para hacer referencia a un decorador usamos `@`

- `@doc`: Documentar.
- `@error`: Definir un tipo de error.
- `@tag`: Categorizar operaciones (para OpenAPI).

```yaml title="Ejemplo decorador"
@error
model ErrorAPI {
  mensaje: string;
  codigo: int32;
}

@get
@doc("Obtiene un usuario por ID")
obtenerUsuario(@path id: string): Usuario | ErrorAPI;
```

```bash title="Ejemplo"
namespace MiTienda;

model Producto {
  @key id: string;
  nombre: string;
  precio: float64;
}

@route("/productos")
interface ProductosAPI {
  @get listar(): Producto[];
  @post crear(@body producto: Producto): void;
  @get obtener(@path id: string): Producto;
}
```

Podemos decorar

- namespaces
- interfaces
- operations
- parameters ( en operations)
- scalars
- models
- members ( en models)

Lo alias NO pueden ser decorados.


## Definición de un Namespace

Los namespaces en TypeSpec nos permiten agrupar tipos relacionados. Esta organización facilita la localización de los tipos y evita conflictos de nombres. Los espacios de nombres se fusionan entre archivos, lo que permite referenciar cualquier tipo desde cualquier lugar del programa TypeSpec utilizando su espacio de nombres.

```typespec
namespace MyAPI;
```

- Agrupa definiciones relacionadas con una API.

```bash title="Ejemplo"
import "@typespec/http";

@service
namespace MyAPI{
  model Usuario{

  }
}
```

## Definición de Rutas (Endpoints)

```typespec
@route("/usuarios")
interface Usuarios {
  @get listar(): Usuario[];
  @get obtener(@path id: ID): Usuario;
  @post crear(@body usuario: Usuario): void;
}
```

- **Decoradores**: 
    - `@route`, 
    - `@get`, 
    - `@post`, 
    - `@body`, 
    - `@path`, 
    - etc.
- **Operaciones HTTP**: Define métodos y parámetros.


## Directivas

Las directivas son anotaciones predefinidas que se adjuntan a los nodos de sintaxis, a diferencia de los decoradores, que se transfieren con `model is`, `op is`, etc. Esto significa que cualquier nodo de sintaxis puede tener una directiva (por ejemplo, `alias`).

Estas son las directivas disponibles:

- #deprecated
- #suppress

### #deprecated

La directiva #deprecated permite marcar un nodo y, a través de él, su tipo como obsoleto. Acepta un único argumento: el mensaje de obsolescencia.

```ts title="Ejemplo" 
#deprecated "Use NewUser instead"
model LegacyUser {}

model Post {
  author: LegacyUser;
  //      ^ warning: Deprecated: Use NewUser instead
```

Lo cual resulta en algo como:

```bash title="Salida" linenums="1" hl_lines="11-11"
openapi: 3.0.0
info:
  title: (title)
  version: 0.0.0
tags: []
paths: {}
components:
  schemas:
    LegacyUser:
      type: object
      deprecated: true
    Post:
      type: object
      required:
        - author
      properties:
        author:
          $ref: '#/components/schemas/LegacyUser'
```

Agregar `#suppress` en un nodo que informa una advertencia de desuso suprimirá la advertencia automáticamente.

```ts linenums="1" hl_lines="2-2"
model Post {
  #suppress "Use newAuthor property instead"
  author: LegacyUser; // no need to also suppress the deprecated diagnostic about usage of LegacyUser
}
```


### #suppress

La directiva `#suppress` permite suprimir un diagnóstico de advertencia específico. Requiere dos argumentos:

- El código de diagnóstico que se suprimirá
- Un mensaje que justifique la supresión


```ts 
model Post {
  #suppress "deprecated" "We are not ready to migrate yet"
  author: LegacyUser;
}
```

```ts
#suppress "@typespec/http/no-service-found" "standard library route"
namespace Lib {
  @route("/test") op get(): string;
}
```





