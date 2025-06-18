import Fluent
import Vapor

struct CreateProducto: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("productos")
            .field("id_producto", .int, .identifier(auto: true))
            .field("nombre", .string, .required)
            .field("precio", .double, .required)
            .field("activo", .bool, .required, .sql(.default(true)))
            .field("fecha_creacion", .datetime, .sql(.default(.literal("CURRENT_TIMESTAMP"))))
            .unique(on: "nombre")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("productos").delete()
    }
}
