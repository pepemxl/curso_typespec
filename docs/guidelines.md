# Guías de desarrollo


API Gateway vs API Management

En este curso se abordan 5 de los pilares del manejo de APIs. 


1. Suport multiple protocols
2. Security



- API Governance
    - Discovery
    - Collection
    - Versioning
    - Linters
    - IAM
    - Developer Portal
    - SLA

API is a product


## API lifecycle Management

- API Design
- API Testing
- API Mocking
- API Gateway
- API Security
- API Portal


## Datos

- Separá la logica que limpia datos de la logica que transforma los datos.



## Convención al nombrar variables en TypeSpec

En la documentación podemos encointrar la siguiente tabla:


| Type | Naming | Example |
| ---- | ------ | ------- |
| scalar | camelCase | `scalar uuid extends string;` |
| model | PascalCase | `model User {}` |
| model property | camelCase | `model User {lastName: string}` |
| enum | PascalCase | `enum Direction {}` |
| enum member | camelCase | `enum Direction {up, down}` |
| namespace | PascalCase | `namespace Org.UserRole` |
| interface | PascalCase | `interface Roles {}` |
| operation | camelCase | `op listUsers(): User[];` |
| operation params | camelCase | `op getUser(userId: string): User;` |
| unions | PascalCase | `union User {employee: Employee, merchant: Merchant}` |
| unions variants | camelCase | `union User {employee: Employee, merchant: Merchant}` |
| alias | camelCase or PascalCase depending on context | `alias myString = string or alias MyAge = Age` |
| decorators | camelCase | `@format, @resourceCollection` |
| functions | camelCase | `addedAfter` |
| file name | kebab-case | `my-lib.tsp` |
| template parameter | PascalCase | `<ExampleParameter>` |