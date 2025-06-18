import Fluent
import Vapor

struct RecetaController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let recetas = routes.grouped("recetas")

        recetas.get(use: self.index)
        recetas.post(use: self.create)
        recetas.put(":id", use: self.update)
        recetas.delete(":id", use: self.delete)
    }

    func index(req: Request) async throws -> [Receta] {
        try await Receta.query(on: req.db)
            .with(\.$producto)
            .with(\.$ingrediente)
            .all()
    }

    func create(req: Request) async throws -> Receta {
        let receta = try req.content.decode(Receta.self)
        try await receta.save(on: req.db)
        return receta
    }

    func update(req: Request) async throws -> Receta {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }

        let input = try req.content.decode(Receta.self)
        guard let receta = try await Receta.find(id, on: req.db) else {
            throw Abort(.notFound)
        }

        receta.$producto.id = input.$producto.id
        receta.$ingrediente.id = input.$ingrediente.id
        receta.cantidad = input.cantidad

        try await receta.save(on: req.db)
        return receta
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let id = req.parameters.get("id", as: UUID.self),
              let receta = try await Receta.find(id, on: req.db) else {
            throw Abort(.notFound)
        }

        try await receta.delete(on: req.db)
        return .noContent
    }
}
