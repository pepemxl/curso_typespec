# Sintaxis básica

## Sintaxis Básica

Puedes checar toda la sintaxis en el sitio [https://typespec.io/docs/language-basics/overview/](https://typespec.io/docs/language-basics/overview/)

### Imports

Tenemos tres imports básicos:

| Feature | Ejemplo |
| ------- | ------- |
| Import de archivo TypeSpec | `import "./models.tsp"` |
| Import de archivo JS | `import "./models.js"` |
| Import de Librería | `import "@typespec/rest"` |

### Declaración de variables(Identifiers)

La declariación de variables(Identifiers) debe ser única dentro del mismo scope.

```yaml title="No permitido"
namespace User {}
model User {}
```

Ejemplos:

- ✅ cat
- ✅ Dog
- ✅ _Item2
- ✅ $money$
- ✅ 🎉
- ✅ 🚀
- ❌ 1cat
- ❌ *dog

### Definición de un Namespace
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



### Modelado de Tipos Básicos

#### a) Tipos primitivos:
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

#### b) Tipos personalizados:

```typespec
alias ID = string;
model Producto {
  id: ID;
  precio: float64;
}
```

### Definición de Rutas (Endpoints)

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

### Uniones y Enums

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

### Generics (Tipos Genéricos)

```typespec
model Paginado<T> {
  items: T[];
  total: int32;
}

@get
listarProductos(): Paginado<Producto>;
```

### Decoradores Comunes

- `@doc`: Documentación.
- `@error`: Define un tipo de error.
- `@tag`: Categoriza operaciones (para OpenAPI).

```typespec
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






