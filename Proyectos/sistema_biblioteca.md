# Proyecto: Sistema de Gestión de Biblioteca

## Descripción

Sistema de base de datos para gestionar libros, socios y préstamos de una biblioteca.

---

## Modelo de Datos

### Tablas

- **socios** — Personas registradas en la biblioteca
- **libros** — Catálogo de libros disponibles
- **autores** — Autores de los libros
- **libro_autor** — Relación N:M entre libros y autores
- **prestamos** — Registro de préstamos activos y pasados

---

## Scripts SQL

```sql
CREATE DATABASE IF NOT EXISTS biblioteca;
USE biblioteca;

CREATE TABLE socios (
    id_socio     INT          NOT NULL AUTO_INCREMENT,
    nombre       VARCHAR(100) NOT NULL,
    apellido     VARCHAR(100) NOT NULL,
    email        VARCHAR(150) NOT NULL UNIQUE,
    fecha_alta   DATE         DEFAULT (CURRENT_DATE),
    activo       BOOLEAN      DEFAULT TRUE,
    PRIMARY KEY (id_socio)
);

CREATE TABLE autores (
    id_autor     INT          NOT NULL AUTO_INCREMENT,
    nombre       VARCHAR(100) NOT NULL,
    apellido     VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(60),
    PRIMARY KEY (id_autor)
);

CREATE TABLE libros (
    id_libro     INT          NOT NULL AUTO_INCREMENT,
    titulo       VARCHAR(255) NOT NULL,
    isbn         VARCHAR(20)  NOT NULL UNIQUE,
    anio_pub     YEAR,
    copias_total INT          NOT NULL DEFAULT 1,
    copias_disp  INT          NOT NULL DEFAULT 1,
    PRIMARY KEY (id_libro)
);

CREATE TABLE libro_autor (
    id_libro  INT NOT NULL,
    id_autor  INT NOT NULL,
    PRIMARY KEY (id_libro, id_autor),
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro)  ON DELETE CASCADE,
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor) ON DELETE CASCADE
);

CREATE TABLE prestamos (
    id_prestamo    INT  NOT NULL AUTO_INCREMENT,
    id_socio       INT  NOT NULL,
    id_libro       INT  NOT NULL,
    fecha_prestamo DATE NOT NULL DEFAULT (CURRENT_DATE),
    fecha_devol    DATE NOT NULL,
    fecha_real_dev DATE,
    PRIMARY KEY (id_prestamo),
    FOREIGN KEY (id_socio) REFERENCES socios(id_socio),
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro)
);
```

---

## Consultas de ejemplo

```sql
-- Libros disponibles para préstamo
SELECT titulo, isbn, copias_disp
FROM libros
WHERE copias_disp > 0;

-- Préstamos activos (sin devolver)
SELECT
    s.nombre, s.apellido,
    l.titulo,
    p.fecha_prestamo,
    p.fecha_devol
FROM prestamos p
JOIN socios s ON p.id_socio = s.id_socio
JOIN libros  l ON p.id_libro  = l.id_libro
WHERE p.fecha_real_dev IS NULL;

-- Socios con préstamos vencidos
SELECT DISTINCT s.nombre, s.apellido, s.email
FROM prestamos p
JOIN socios s ON p.id_socio = s.id_socio
WHERE p.fecha_real_dev IS NULL
  AND p.fecha_devol < CURRENT_DATE;
```
