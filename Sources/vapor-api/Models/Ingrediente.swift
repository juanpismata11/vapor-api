import Fluent
import struct Foundation.UUID

/// Property wrappers interact poorly with `Sendable` checking, causing a warning for the `@ID` property
/// It is recommended you write your model with sendability checking on and then suppress the warning
/// afterwards with `@unchecked Sendable`.
final class Ingrediente: Model, @unchecked Sendable {
    static let schema = "ingredientes"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "nombre")
    var nombre: String

    @Field(key: "cantidad")
    var cantidad: Int

    @Field(key: "unidad")
    var unidad: String
    
    @Field(key: "precio_unitario")
    var precioUnitario: Double

    init() { }

    init(id: UUID? = nil, nombre: String, cantidad: Int, unidad: String, precio_unitario: Double) {
        self.nombre = nombre
        self.cantidad = cantidad
        self.unidad = unidad
        self.precio_unitario = precio_unitario
    }
}
