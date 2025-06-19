# Sintaxis básica

## Sintaxis Básica

Puedes checar toda la sintaxis en el sitio [https://typespec.io/docs/language-basics/overview/](https://typespec.io/docs/language-basics/overview/)

vamos a revisar parte de la sintaxis básica que nos permitira trabajar en los proyectos.

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


## Imports

Usamos imports para incluir ya sean archivos o librerías en nuestros programas de typespec.

Tenemos tres imports básicos:

| Feature | Ejemplo |
| ------- | ------- |
| Import de archivo TypeSpec | `import "./models.tsp"` |
| Import de archivo JS | `import "./models.js"` |
| Import de Librería | `import "@typespec/rest"` |

```bash title="Ejemplo"
import "@typespec/http";
```


## Generics (Tipos Genéricos)

```typespec
model Paginado<T> {
  items: T[];
  total: int32;
}

@get
listarProductos(): Paginado<Producto>;
```


## Modelado de Tipos Básicos

### a) Tipos primitivos:
```typespec
model Usuario {
  nombre: string;
  edad: int32;
  activo: boolean;
}
```
- `string`, 
- `int32`, 
- `boolean`, 
- `float64`, 
- etc.

### b) Tipos personalizados:

```typespec
alias ID = string;
model Producto {
  id: ID;
  precio: float64;
}
```


## Tipos de Datos Nativos

### Tipos de Datos Fecha Hora

| Tipo | Descripción |
| --- |  --- |
| plainDate | Día de calendario |
| plainTime | Hora |
| utcDateTime | Día Hora en UTC |
| offsetDateTime | Día Hora en zona horaria |
| duration | Periodo de tiempo |


### Tipos Númericos


| Tipo | Rango | Descripción |
| --- | --- | --- |
| numeric | * | Tipo padre de todos los tipos númericos |
| integer | * | Enteros |
| float | * | Números binarios |
| int64 | -9,223,372,036,854,775,808 a 9,223,372,036,854,775,807 | Entero de 64 bits |
| int32 |  | Entero de 32 bits |
| int16 |  | Entero de 16 bits |
| int8 |  | Entero de 8 bits |
| safeint |  | Entero que puede ser serializado en un JSON |
| uint64 |  | entero sin signo de 64 bits |
| uint32 |  | entero sin signo de 32 bits |
| uint16 |  | entero sin signo de 16 bits |
| uint8 |  | entero sin signo de 8 bits |
| float32 |  | número flotante de 32 bits |
| float64 |  | número flotante de 64 bits |
| decimal | * | número decimal |
| decimal128 |  | número decimal de 128 bits |

### Tipo Core

| Tipo |  Descripción |
| --- | --- |
| bytes | Secuencia de bytes |
| string | Cadena de caracteres |
| boolean | Boolean |
| null | Valor NULL |
| Array<Element> | Arreglo de un tipo de modelo equivalente a Element[] |
| Record<Element> | Modelo con llaves string(Diccionario) Equivalente a Map<string, Element> o Dictionary<string, Element> |
| unknown | equivalente al tipo any |
| void | Indicador de que no retorna nada |
| never | Indica que nunca occure el valor |


### Tipo String

| Tipo |  Descripción |
| --- | --- |
| url | Un url string |


## Uniones y Enums

```typespec
model Respuesta {
  resultado: "éxito" | "error"; // Unión de strings
  codigo: 200 | 404; // Unión de números
}

enum Estado {
  Activo,
  Inactivo,
  Pendiente,
}
```









