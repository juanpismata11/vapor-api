import Fluent
import Vapor

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

    init(id: Int? = nil,productoID: UUID, ingredienteID: UUID, cantidad: Double) {
        self.id = id
        self.$producto.id = productoID
        self.$ingrediente.id = ingredienteID
        self.cantidad = cantidad
    }
}
