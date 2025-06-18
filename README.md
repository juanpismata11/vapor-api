# HOT DOGS/TOPS

## Integrantes:
- Edgar Leonel Castro Mendez
- Paulina Giovanna Orozco  De Alba
- Javier Herminio Marín Telléz
- Juan Pablo Mata Aguirre
- Frida Julieta Gonzaléz Mena

## Descripción 
App para llevar el inventario de un negocio de Jochos donde los usuarios pueden ver los ingredientes (nombre, stock y fecha creación), Productos (nombre, precio, activo, fecha de creación) y Recetas (id_Producto, 
id_Ingredientes, cantidad)

#  API de Recetas - Vapor

API RESTful desarrollada con **Vapor (Swift)** para gestionar productos, ingredientes y recetas de cocina. Esta API es consumida por una app de macOS desarrollada en SwiftUI.

##  Estructura del Proyecto

- `Models/` – Modelos de datos (`Ingrediente`, `Producto`, `Receta`)
- `Controllers/` – Lógica de endpoints (en desarrollo)
- `DTOs/` – Objetos de transferencia de datos (si se usan)
- `Migrations/` – Migraciones para la base de datos
- `routes.swift` – Rutas REST
- `configure.swift` – Configuración general
- `Dockerfile` – Para contenerización del proyecto

##  Endpoints REST

- `GET /productos`
- `POST /productos`
- `GET /ingredientes`
- `POST /ingredientes`
- `GET /recetas`
- `POST /recetas`

##  Docker

Construcción y ejecución local:

## Models

### Ingrediente:

```swift
import Fluent
import Vapor
import Foundation
```
#### Importa los frameworks necesarios:

- Fluent: ORM para manejar base de datos con modelos en Swift.
- Vapor: Framework web en Swift.
- Foundation: Utilidades generales como Date, Double, etc.


```swift
final class Ingrediente: Model, Content, @unchecked Sendable {
    static let schema = "ingredientes"
```
#### Define una clase final llamada Ingrediente.
#### Hereda de:
- `Model`: indica que este objeto se guarda en base de datos.
- `Content`: permite que pueda convertirse a/desde JSON (por ejemplo, en peticiones HTTP).
- `@unchecked` Sendable: habilita concurrencia sin que el compilador valide la seguridad de hilos (es útil, pero debes tener cuidado si usas threading).

- `static let schema = "ingredientes"`: Define el nombre de la tabla en la base de datos: ingredientes

```swift 
    @ID(custom: "id_ingrediente")
    var id: Int?
```
#### Define la clave primaria del modelo.

custom: "id_ingrediente" indica que en lugar de llamarse id, la columna en la BD se llama id_ingrediente.

```swift
    @Field(key: "nombre")
    var nombre: String
```
Campo obligatorio `(String)` que representa el nombre del ingrediente.

```swift
    @Enum(key: "unidad_medida")
    var unidadMedida: UnidadMedida

```
#### Campo de tipo enum llamado `unidadMedida`.

Se guarda como texto en la columna `unidad_medida`.
Solo acepta valores definidos en el `enum UnidadMedida`.
```swift
    @Field(key: "stock_actual")
    var stockActual: Double
```
Campo que representa el stock actual disponible del ingrediente.
```swift
    @Field(key: "stock_minimo")
    var stockMinimo: Double
```
Campo que indica la `cantidad mínima` deseada antes de considerar que hay poco stock.
```swift
    @Field(key: "costo")
    var costo: Double
```
Campo que guarda el `costo` por unidad del ingrediente.
```swift
    @Timestamp(key: "fecha_actualizacion", on: .update)
    var fechaActualizacion: Date?
```
 Campo especial que guarda la fecha de última modificación automática.

Se actualiza cada vez que se modifica el modelo (gracias a `.update`).

```swift
    init() { }
    
    init(
        id: Int? = nil,
        nombre: String,
        unidadMedida: UnidadMedida,
        stockActual: Double,
        stockMinimo: Double,
        costo: Double
    ) {
        self.id = id
        self.nombre = nombre
        self.unidadMedida = unidadMedida
        self.stockActual = stockActual
        self.stockMinimo = stockMinimo
        self.costo = costo
    }
}
```
Constructor personalizado para crear un `Ingrediente` manualmente con todos sus campos (menos `fechaActualizacion`, porque es automática).
```swift
enum UnidadMedida: String, Codable, CaseIterable {
    case unidad = "unidad"
    case kilogramo = "kg"
    case litro = "lt"
    case gramo = "gr"
    case mililitro = "ml"
}
```
#### Define un tipo enumerado que:
- Es una cadena `(String)`
- Se puede codificar/decodificar como JSON (`Codable`)
- Tiene todos sus valores accesibles como lista (`CaseIterable`), útil para listas en formularios.

#### Valores aceptados como unidad de medida. Se guardan como texto en la base de datos.
- Ejemplos: “kg”, “lt”, “gr”, etc.

## Producto
```swift
```

```swift
```

```swift
```







