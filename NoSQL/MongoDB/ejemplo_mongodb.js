// ============================================================
// MongoDB - Operaciones básicas
// Ejecutar en MongoDB Shell (mongosh)
// ============================================================

// Seleccionar / crear base de datos
use tienda_nosql

// ─────────────────────────────────────────────
// Insertar documentos
// ─────────────────────────────────────────────

db.clientes.insertMany([
  {
    nombre: "Ana García",
    email: "ana.garcia@email.com",
    telefono: "555-1001",
    direccion: { ciudad: "Madrid", pais: "España" },
    fecha_registro: new Date()
  },
  {
    nombre: "Carlos Martínez",
    email: "carlos.m@email.com",
    telefono: "555-1002",
    direccion: { ciudad: "Barcelona", pais: "España" },
    fecha_registro: new Date()
  }
])

db.productos.insertMany([
  { nombre: "Laptop Pro 15",     precio: 1299.99, stock: 10, categoria: "Electrónica" },
  { nombre: "Mouse Inalámbrico", precio: 25.99,   stock: 50, categoria: "Periféricos" },
  { nombre: "Teclado Mecánico",  precio: 89.99,   stock: 30, categoria: "Periféricos" }
])

// ─────────────────────────────────────────────
// Consultas (find)
// ─────────────────────────────────────────────

// Todos los clientes
db.clientes.find()

// Productos con precio menor a 100
db.productos.find({ precio: { $lt: 100 } })

// Proyección: solo nombre y precio
db.productos.find({}, { nombre: 1, precio: 1, _id: 0 })

// Ordenar por precio descendente
db.productos.find().sort({ precio: -1 })

// ─────────────────────────────────────────────
// Actualizar documentos
// ─────────────────────────────────────────────

// Actualizar el stock de un producto
db.productos.updateOne(
  { nombre: "Laptop Pro 15" },
  { $set: { stock: 8 } }
)

// Incrementar el precio de todos los periféricos un 5%
db.productos.updateMany(
  { categoria: "Periféricos" },
  { $mul: { precio: 1.05 } }
)

// ─────────────────────────────────────────────
// Eliminar documentos
// ─────────────────────────────────────────────

// Eliminar un documento específico
// db.productos.deleteOne({ nombre: "Mouse Inalámbrico" })

// Eliminar todos los productos sin stock
// db.productos.deleteMany({ stock: 0 })

// ─────────────────────────────────────────────
// Agregaciones (pipeline)
// ─────────────────────────────────────────────

// Total de productos por categoría
db.productos.aggregate([
  { $group: { _id: "$categoria", total: { $sum: 1 }, precio_promedio: { $avg: "$precio" } } },
  { $sort: { total: -1 } }
])

// ─────────────────────────────────────────────
// Índices en MongoDB
// ─────────────────────────────────────────────

// Crear índice en el campo email
db.clientes.createIndex({ email: 1 }, { unique: true })

// Ver índices de una colección
db.clientes.getIndexes()
