import Fluent
import Foundation

final class Receta: Model, Content, @unchecked Sendable {
    static let schema = "recetas"

    @ID(key: .id)
    var id: UUID?

    @Parent(key: "id_producto")
    var producto: Producto

    @Parent(key: "id_ingrediente")
    var ingrediente: Ingrediente

    @Field(key: "cantidad")
    var cantidad: Double

    init() {}

    init(productoID: UUID, ingredienteID: UUID, cantidad: Double) {
        self.$producto.id = productoID
        self.$ingrediente.id = ingredienteID
        self.cantidad = cantidad
    }
}
