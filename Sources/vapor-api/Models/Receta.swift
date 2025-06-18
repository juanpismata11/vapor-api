import Fluent
import Foundation
import Vapor

final class Receta: Model, Content, @unchecked Sendable {
    static let schema = "recetas"

    @ID(custom: "id_receta")
    var id: Int?

    @Parent(key: "id_producto")
    var producto: Producto

    @Parent(key: "id_ingrediente")
    var ingrediente: Ingrediente

    @Field(key: "cantidad")
    var cantidad: Double

    init() {}

    init(id: Int? = nil, productoID: Int, ingredienteID: Int, cantidad: Double) {
        self.id = id
        self.$producto.id = productoID
        self.$ingrediente.id = ingredienteID
        self.cantidad = cantidad
    }
}
