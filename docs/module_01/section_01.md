# ¿Qué es TypeSpec?


[Typespec Docs](https://typespec.io/docs/)


TypeSpec es un lenguaje de definición/descripción de API desarrollado por Microsoft, el cual es agnostico a los lenguages de programación. Diseñado especialmente para crear APIs, a partir del diseño de la data de nuestros servicios.

El flujo usual es:

<div>
<span align="center"> 
<img src="../images/flujo_typespec.png" width="90%"/>
</span>
<div>


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





## La Arquitectura de TypeSpec

El eje central de typespec es el `compiler`, sin embargo para los usuarios de typespec nuestro principal atención será alrededor de `Emitters`. Más adelante profundizaremos en los elementos de typespec para poder extender y customizar nuestras implementaciones.

<div>
<span align="center">
<img src="../images/arquitectura_de_typespec.png" width="90%"/>
</span>
</div>


## Plugin para Visual Studio Code

[Link a plugin](https://marketplace.visualstudio.com/items?itemName=typespec.typespec-vscode)

