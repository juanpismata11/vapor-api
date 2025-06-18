import Fluent
import Vapor

struct CreateReceta: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("recetas")
            .field("id_receta", .int, .identifier(auto: true))
            .field("id_producto", .int, .required, .references("productos", "id_producto", onDelete: .cascade))
            .field("id_ingrediente", .int, .required, .references("ingredientes", "id_ingrediente"))
            .field("cantidad", .double, .required)
            .unique(on: "id_producto", "id_ingrediente")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("recetas").delete()
    }
}
