import Fluent
import Foundation

final class Ingrediente: Model, Content, @unchecked Sendable {
    static let schema = "ingredientes"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "nombre")
    var nombre: String

    @Field(key: "unidad_medida")
    var unidadMedida: String

    @Field(key: "stock_actual")
    var stockActual: Double

    @Field(key: "stock_minimo")
    var stockMinimo: Double

    @Field(key: "costo")
    var costo: Double

    @Timestamp(key: "fecha_actualizacion", on: .update)
    var fechaActualizacion: Date?

    init() {}

    init(nombre: String, unidadMedida: String, stockActual: Double, stockMinimo: Double, costo: Double) {
        self.nombre = nombre
        self.unidadMedida = unidadMedida
        self.stockActual = stockActual
        self.stockMinimo = stockMinimo
        self.costo = costo
    }
}
