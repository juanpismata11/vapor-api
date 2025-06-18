import Fluent
import Foundation

final class Producto: Model, Content, @unchecked Sendable {
    static let schema = "productos"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "nombre")
    var nombre: String

    @Field(key: "precio")
    var precio: Double

    @Field(key: "activo")
    var activo: Bool

    @Timestamp(key: "fecha_creacion", on: .create)
    var fechaCreacion: Date?

    init() {}

    init(nombre: String, precio: Double, activo: Bool) {
        self.nombre = nombre
        self.precio = precio
        self.activo = activo
    }
}