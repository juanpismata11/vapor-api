import Fluent
import Vapor

struct IngredienteController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let ingredientes = routes.grouped("ingredientes")

        ingredientes.get(use: self.index)
        ingredientes.post(use: self.create)
        ingredientes.put(":id", use: self.update)
        ingredientes.delete(":id", use: self.delete)
    }

    func index(req: Request) async throws -> [Ingrediente] {
        try await Ingrediente.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Ingrediente {
        let ingrediente = try req.content.decode(Ingrediente.self)
        try await ingrediente.save(on: req.db)
        return ingrediente
    }

    func update(req: Request) async throws -> Ingrediente {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }

        let input = try req.content.decode(Ingrediente.self)

        guard let ingrediente = try await Ingrediente.find(id, on: req.db) else {
            throw Abort(.notFound)
        }

        ingrediente.nombre = input.nombre
        ingrediente.unidadMedida = input.unidadMedida
        ingrediente.stockActual = input.stockActual
        ingrediente.stockMinimo = input.stockMinimo
        ingrediente.costo = input.costo

        try await ingrediente.save(on: req.db)
        return ingrediente
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let id = req.parameters.get("id", as: UUID.self),
              let ingrediente = try await Ingrediente.find(id, on: req.db) else {
            throw Abort(.notFound)
        }

        try await ingrediente.delete(on: req.db)
        return .noContent
    }
}
