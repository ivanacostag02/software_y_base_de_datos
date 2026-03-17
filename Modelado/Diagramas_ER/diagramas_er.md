# Diagramas Entidad-Relación (ER)

## ¿Qué es un Diagrama ER?

Un **Diagrama Entidad-Relación** es una representación gráfica de la estructura lógica de una base de datos. Muestra las **entidades**, sus **atributos** y las **relaciones** entre ellas.

---

## Elementos principales

| Elemento | Símbolo | Descripción |
|---------|---------|-------------|
| **Entidad** | Rectángulo | Objeto o concepto del dominio (ej. Cliente, Producto) |
| **Atributo** | Elipse | Propiedad de una entidad (ej. nombre, precio) |
| **Relación** | Rombo | Asociación entre dos o más entidades |
| **Atributo clave** | Elipse subrayada | Identifica unívocamente una instancia |

---

## Cardinalidades

- **1:1** — Un cliente tiene una sola cuenta bancaria
- **1:N** — Un cliente puede tener muchos pedidos
- **N:M** — Un pedido puede incluir muchos productos y un producto puede estar en muchos pedidos

---

## Ejemplo: Sistema de Tienda

```
┌──────────┐       realiza       ┌──────────┐       contiene      ┌───────────┐
│ CLIENTE  │ ─────────────────── │  PEDIDO  │ ─────────────────── │ PRODUCTO  │
├──────────┤   1             N   ├──────────┤   N             M   ├───────────┤
│ id (PK)  │                     │ id (PK)  │                     │ id (PK)   │
│ nombre   │                     │ fecha    │                     │ nombre    │
│ email    │                     │ total    │                     │ precio    │
│ telefono │                     │          │                     │ stock     │
└──────────┘                     └──────────┘                     └───────────┘
```

La relación **N:M** entre `PEDIDO` y `PRODUCTO` se resuelve con la tabla intermediaria `DETALLE_PEDIDO`:

```
┌──────────┐           ┌────────────────┐           ┌───────────┐
│  PEDIDO  │ ───────── │ DETALLE_PEDIDO │ ───────── │ PRODUCTO  │
└──────────┘   1    N  ├────────────────┤  N    1   └───────────┘
               id_pedido (FK)           id_producto (FK)
               cantidad
               precio_unit
```

---

## Herramientas recomendadas

- [draw.io](https://draw.io) — Gratuito, online
- [MySQL Workbench](https://www.mysql.com/products/workbench/) — Para MySQL
- [dbdiagram.io](https://dbdiagram.io) — Diagramas con código
- [Lucidchart](https://lucidchart.com) — Colaborativo
