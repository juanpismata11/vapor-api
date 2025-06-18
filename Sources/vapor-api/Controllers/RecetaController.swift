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
        do {
            return try await Receta.query(on: req.db)
                .with(\.$producto)
                .with(\.$ingrediente)
                .all()
        } catch {
            req.logger.error("Error al obtener recetas: \(error.localizedDescription)")
            req.logger.report(error: error)
            throw Abort(.internalServerError, reason: "No se pudieron obtener las recetas.")
        }
    }

    func create(req: Request) async throws -> Receta {
        do {
            let receta = try req.content.decode(Receta.self)
            try await receta.save(on: req.db)
            return receta
        } catch {
            req.logger.error("Error al crear receta: \(error.localizedDescription)")
            req.logger.report(error: error)
            throw Abort(.internalServerError, reason: "No se pudo crear la receta.")
        }
    }

    func update(req: Request) async throws -> Receta {
        do {
            guard let id = req.parameters.get("id", as: Int.self) else {
                throw Abort(.badRequest, reason: "ID inválido.")
            }

            let input = try req.content.decode(Receta.self)

            guard let receta = try await Receta.find(id, on: req.db) else {
                throw Abort(.notFound, reason: "Receta no encontrada.")
            }

            receta.$producto.id = input.$producto.id
            receta.$ingrediente.id = input.$ingrediente.id
            receta.cantidad = input.cantidad

            try await receta.save(on: req.db)
            return receta
        } catch {
            req.logger.error("Error al actualizar receta: \(error.localizedDescription)")
            req.logger.report(error: error)
            throw Abort(.internalServerError, reason: "No se pudo actualizar la receta.")
        }
    }

    func delete(req: Request) async throws -> HTTPStatus {
        do {
            guard let id = req.parameters.get("id", as: Int.self),
                  let receta = try await Receta.find(id, on: req.db) else {
                throw Abort(.notFound, reason: "Receta no encontrada.")
            }

            try await receta.delete(on: req.db)
            return .noContent
        } catch {
            req.logger.error("Error al eliminar receta: \(error.localizedDescription)")
            req.logger.report(error: error)
            throw Abort(.internalServerError, reason: "No se pudo eliminar la receta.")
        }
    }
}
