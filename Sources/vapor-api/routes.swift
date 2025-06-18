import Fluent
import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: IngredienteController())
    try app.register(collection: ProductoController())
    try app.register(collection: RecetaController())
}
