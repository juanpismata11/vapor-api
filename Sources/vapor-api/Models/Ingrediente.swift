import Fluent
import Vapor
import Foundation

final class Ingrediente: Model, Content, @unchecked Sendable {
    static let schema = "ingredientes"
    
    @ID(custom: "id_ingrediente")
    var id: Int?
    
    @Field(key: "nombre")
    var nombre: String
    
    @Enum(key: "unidad_medida")
    var unidadMedida: UnidadMedida
    
    @Field(key: "stock_actual")
    var stockActual: Double
    
    @Field(key: "stock_minimo")
    var stockMinimo: Double
    
    @Field(key: "costo")
    var costo: Double
    
    @Timestamp(key: "fecha_actualizacion", on: .update)
    var fechaActualizacion: Date?
    
    init() { }
    
    init(id: Int? = nil, nombre: String, unidadMedida: UnidadMedida, stockActual: Double, stockMinimo: Double, costo: Double) {
        self.id = id
        self.nombre = nombre
        self.unidadMedida = unidadMedida
        self.stockActual = stockActual
        self.stockMinimo = stockMinimo
        self.costo = costo
    }
}

enum UnidadMedida: String, Codable, CaseIterable {
    case unidad = "unidad"
    case kilogramo = "kg"
    case litro = "lt"
    case gramo = "gr"
    case mililitro = "ml"
}