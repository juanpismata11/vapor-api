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
        do {
            return try await Ingrediente.query(on: req.db).all()
        } catch {
            req.logger.error("Error al obtener ingredientes: \(error.localizedDescription)")
            req.logger.report(error: error)
            throw Abort(.internalServerError, reason: "No se pudieron obtener los ingredientes.")
        }
    }

    func create(req: Request) async throws -> Ingrediente {
        do {
            let ingrediente = try req.content.decode(Ingrediente.self)
            try await ingrediente.save(on: req.db)
            return ingrediente
        } catch {
            req.logger.error("Error al crear ingrediente: \(error.localizedDescription)")
            req.logger.report(error: error)
            throw Abort(.internalServerError, reason: "No se pudo crear el ingrediente.")
        }
    }

    func update(req: Request) async throws -> Ingrediente {
        do {
            guard let id = req.parameters.get("id", as: Int.self) else {
                throw Abort(.badRequest, reason: "ID inválido.")
            }

            let input = try req.content.decode(Ingrediente.self)

            guard let ingrediente = try await Ingrediente.find(id, on: req.db) else {
                throw Abort(.notFound, reason: "Ingrediente no encontrado.")
            }

            ingrediente.nombre = input.nombre
            ingrediente.unidadMedida = input.unidadMedida
            ingrediente.stockActual = input.stockActual
            ingrediente.stockMinimo = input.stockMinimo
            ingrediente.costo = input.costo

            try await ingrediente.save(on: req.db)
            return ingrediente
        } catch {
            req.logger.error("Error al actualizar ingrediente: \(error.localizedDescription)")
            req.logger.report(error: error)
            throw Abort(.internalServerError, reason: "No se pudo actualizar el ingrediente.")
        }
    }

    func delete(req: Request) async throws -> HTTPStatus {
        do {
            guard let id = req.parameters.get("id", as: Int.self),
                  let ingrediente = try await Ingrediente.find(id, on: req.db) else {
                throw Abort(.notFound, reason: "Ingrediente no encontrado.")
            }

            try await ingrediente.delete(on: req.db)
            return .noContent
        } catch {
            req.logger.error("Error al eliminar ingrediente: \(error.localizedDescription)")
            req.logger.report(error: error)
            throw Abort(.internalServerError, reason: "No se pudo eliminar el ingrediente.")
        }
    }
}
