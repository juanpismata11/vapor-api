import Fluent
import Vapor

struct CreateIngrediente: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.enum("unidad_medida_enum")
            .case("unidad").case("kg").case("lt").case("gr").case("ml")
            .create()
        
        try await database.schema("ingredientes")
            .field("id_ingrediente", .int, .identifier(auto: true))
            .field("nombre", .string, .required)
            .field("unidad_medida", .enum("unidad_medida_enum"), .required)
            .field("stock_actual", .double, .required)
            .field("stock_minimo", .double, .required)
            .field("costo", .double, .required)
            .field("fecha_actualizacion", .datetime)
            .unique(on: "nombre")
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema("ingredientes").delete()
        try await database.enum("unidad_medida_enum").delete()
    }
}
