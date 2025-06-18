# HOT DOGS/TOPS

## Integrantes:
- Edgar Leonel Castro Mendez
- Paulina Giovanna Orozco  De Alba
- Javier Herminio Marín Telléz
- Juan Pablo Mata Aguirre
- Frida Julieta Gonzaléz Mena

## Descripción 
App para llevar el inventario de un negocio de Jochos donde los usuarios pueden ver los ingredientes (nombre, stock y fecha creación), Productos (nombre, precio, activo, fecha de creación) y Recetas (id_Producto, 
id_Ingredientes, cantidad)

#  API de Recetas - Vapor

API RESTful desarrollada con **Vapor (Swift)** para gestionar productos, ingredientes y recetas de cocina. Esta API es consumida por una app de macOS desarrollada en SwiftUI.

##  Estructura del Proyecto

- `Models/` – Modelos de datos (`Ingrediente`, `Producto`, `Receta`)
- `Controllers/` – Lógica de endpoints (en desarrollo)
- `DTOs/` – Objetos de transferencia de datos (si se usan)
- `Migrations/` – Migraciones para la base de datos
- `routes.swift` – Rutas REST
- `configure.swift` – Configuración general
- `Dockerfile` – Para contenerización del proyecto

## 🔌 Endpoints REST (en progreso)

- `GET /productos`
- `POST /productos`
- `GET /ingredientes`
- `POST /ingredientes`
- `GET /recetas`
- `POST /recetas`

(Agrega los que vayas desarrollando con ejemplos si puedes)

##  Docker

Construcción y ejecución local:

```bash
docker compose up --build

