# Plataforma de Autenticación


- Endpoints organizados:
    - `/auth` para operaciones de autenticación
    - `/register` para registro de usuarios
    - `/password` para recuperación de contraseña
- Modelos bien definidos:
    - `UserAuth` para datos de usuario
    - `LoginCredentials` para credenciales de login
    - `AuthResponse` para respuesta de autenticación exitosa
    - `AuthError` para manejo de errores
- Seguridad:
    - Campos marcados como `@secret` para datos sensibles
    - Validaciones con `@minLength`, `@maxLength`, `@format`
    - Soporte para JWT (tokens de acceso y refresco)
- Operaciones clave:
    - Login/logout
    - Refresco de token
    - Verificación de token
    - Registro de usuario
    - Verificación de email
    - Recuperación de contraseña
- Metadata útil:
    - `@summary` para documentación
    - `@description` para aclaraciones
    - `@statusCode` para respuestas específicas

## Seguridad

- Almacenamiento seguro de contraseñas con hash y salt
- Registro de intentos de login
- Gestión de sesiones con tokens

## Funcionalidad

- Verificación de email
- Recuperación de contraseña
- Roles y permisos
- Perfiles de usuario extendidos

## Rendimiento

- Índices en campos de búsqueda frecuente
- Normalización adecuada de tablas

## Auditoría

- Registro de actividades de login
- Trazabilidad de sesiones