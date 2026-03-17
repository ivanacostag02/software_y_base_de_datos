# Normalización de Bases de Datos

## Concepto

La **normalización** es el proceso de organizar los atributos y relaciones de una base de datos para reducir la **redundancia** y mejorar la **integridad** de los datos.

---

## Formas Normales

### 🔴 Tabla sin normalizar (0FN)

| id_pedido | cliente       | email_cliente        | productos                          | cantidades |
|-----------|--------------|---------------------|------------------------------------|-----------|
| 1         | Ana García   | ana@email.com        | Laptop, Mouse                      | 1, 2      |
| 2         | Carlos M.    | carlos@email.com     | Teclado                            | 1         |

**Problemas:** grupos repetitivos, datos mezclados.

---

### 🟡 Primera Forma Normal (1FN)

> **Regla:** Eliminar grupos repetitivos. Cada celda debe contener un único valor atómico.

| id_pedido | cliente     | email_cliente    | producto | cantidad |
|-----------|------------|-----------------|---------|---------|
| 1         | Ana García | ana@email.com   | Laptop  | 1       |
| 1         | Ana García | ana@email.com   | Mouse   | 2       |
| 2         | Carlos M.  | carlos@email.com| Teclado | 1       |

**Clave primaria compuesta:** `(id_pedido, producto)`

---

### 🟠 Segunda Forma Normal (2FN)

> **Regla:** Estar en 1FN y que todos los atributos no clave dependan **completamente** de la clave primaria (eliminar dependencias parciales).

**Tabla `pedidos`:**

| id_pedido | id_cliente | fecha      |
|-----------|-----------|------------|
| 1         | 1         | 2024-01-15 |
| 2         | 2         | 2024-01-20 |

**Tabla `clientes`:**

| id_cliente | nombre      | email            |
|-----------|------------|-----------------|
| 1         | Ana García | ana@email.com   |
| 2         | Carlos M.  | carlos@email.com|

**Tabla `detalle_pedido`:**

| id_pedido | id_producto | cantidad |
|-----------|------------|---------|
| 1         | 1          | 1       |
| 1         | 2          | 2       |
| 2         | 3          | 1       |

---

### 🟢 Tercera Forma Normal (3FN)

> **Regla:** Estar en 2FN y eliminar **dependencias transitivas** (atributos no clave que dependen de otro atributo no clave).

Si hubiera `ciudad → código_postal` en la tabla de clientes, se separaría en su propia tabla:

**Tabla `ciudades`:**

| id_ciudad | nombre   | codigo_postal |
|----------|---------|--------------|
| 1        | Madrid  | 28001        |
| 2        | Buenos Aires | C1000 |

**Tabla `clientes` (actualizada):**

| id_cliente | nombre      | email            | id_ciudad |
|-----------|------------|-----------------|---------|
| 1         | Ana García | ana@email.com   | 1       |
| 2         | Carlos M.  | carlos@email.com| 2       |

---

### 🔵 Forma Normal de Boyce-Codd (BCNF)

> **Regla:** Estar en 3FN y que cada determinante sea una clave candidata.

Es una versión más estricta de la 3FN. Se aplica cuando hay múltiples claves candidatas que se superponen.

---

## Resumen

| Forma Normal | Qué elimina |
|-------------|-------------|
| 1FN         | Grupos repetitivos y valores no atómicos |
| 2FN         | Dependencias parciales de la clave primaria |
| 3FN         | Dependencias transitivas |
| BCNF        | Anomalías con claves candidatas superpuestas |
