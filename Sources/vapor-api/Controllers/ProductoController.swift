import Fluent
import Vapor

struct ProductoController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let productos = routes.grouped("productos")

        productos.get(use: self.index)
        productos.post(use: self.create)
        productos.put(":id", use: self.update)
        productos.delete(":id", use: self.delete)
    }

    func index(req: Request) async throws -> [Producto] {
        try await Producto.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Producto {
        let producto = try req.content.decode(Producto.self)
        try await producto.save(on: req.db)
        return producto
    }

   func update(req: Request) async throws -> Producto {
        guard let id = req.parameters.get("id", as: Int.self) else {
            throw Abort(.badRequest)
        }

        let input = try req.content.decode(Producto.self)

        guard let producto = try await Producto.find(id, on: req.db) else {
            throw Abort(.notFound)
        }

        producto.nombre = input.nombre
        producto.precio = input.precio
        producto.activo = input.activo

        try await producto.save(on: req.db)
        return producto
    }


    func delete(req: Request) async throws -> HTTPStatus {
        guard let id = req.parameters.get("id", as: Int.self),
              let producto = try await Producto.find(id, on: req.db) else {
            throw Abort(.notFound)
        }

        try await producto.delete(on: req.db)
        return .noContent
    }
}
