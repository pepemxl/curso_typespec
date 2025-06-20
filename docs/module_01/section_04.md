# Sintaxis básica (Continuación)

## Sintaxis Básica

Puedes checar toda la sintaxis en el sitio [https://typespec.io/docs/language-basics/overview/](https://typespec.io/docs/language-basics/overview/)

vamos a revisar parte de la sintaxis básica que nos permitira trabajar en los proyectos.


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