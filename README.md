# 🧸 DCCjuguete

## 🌐 Acceso a la tienda

La tienda se encuentra en el siguiente enlace:

👉 **[https://two026-1-grupo-104.onrender.com/](https://two026-1-grupo-104.onrender.com/)**

---

## 🗄️ Modelo Entidad-Relación

A continuación se presenta el diagrama E/R del sistema:

📄 **[Ver Modelo E/R](docs/modelo_entidad_relacion.pdf)**


# Documentación de DCCastillo 🏰
 
## Descripción General
 
Este proyecto es una plataforma de Compra - Venta en la que participan tres tipos de usuarios **clientes**, **vendedores** y **administradores**
 
---
## Roles y Funcionalidades
 
### 1. Cliente
 
El cliente es el usuario que navega la plataforma con el objetivo de descubrir y adquirir productos.
 
**Mensajería:**
El cliente puede iniciar conversaciones con vendedores y recibir respuestas de ellos. Esto le permite hacer preguntas sobre un producto antes de comprarlo, resolver dudas directamente con quien lo vende, etc.
 
**Favoritos:**
El cliente puede marcar productos como favoritos para guardarlos y acceder a ellos fácilmente más adelante, sin necesidad de volver a buscarlos.
 
**Compra de productos:**
Una vez que el cliente decide adquirir un producto, puede realizar la compra directamente desde la plataforma.
 
**Reporte de reseñas:**
Si el cliente encuentra una reseña que considera inapropiada (por ejemplo, con contenido ofensivo, falso o que viola las normas de la plataforma), puede reportarla. El reporte queda registrado para que el administrador lo evalúe.
 
---
 
### 2. Vendedor
 
El vendedor es quien ofrece productos dentro de la plataforma. Tiene control total sobre su catálogo, puede comunicarse directamente con sus potenciales compradores y decide si acepta o rechaza cada solicitud de compra.
 
**Publicación de productos:**
El vendedor puede crear nuevas publicaciones en la plataforma, especificando la información relevante del producto como nombre, descripción, precio e imágenes.
 
**Edición de productos:**
Si necesita actualizar algún dato de un producto ya publicado (por ejemplo, modificar el precio o corregir la descripción), el vendedor puede editarlo en cualquier momento.
 
**Eliminación de productos:**
Cuando un producto deja de estar disponible, el vendedor puede eliminarlo de la plataforma para que no sea visible ni comprable por los clientes.
 
**Gestión de compras:**
Cuando un cliente solicita comprar un producto, el vendedor recibe la solicitud y decide si la acepta o la rechaza. Esto le da al vendedor control sobre a quién le vende.
 
**Mensajería:**
El vendedor puede recibir mensajes de clientes interesados en sus productos y responderles. Esta comunicación es bidireccional y permite coordinar ventas o aclarar consultas.

 
---
 
### 3. Administrador
 
El administrador es el responsable de mantener el orden e integridad de la plataforma. No compra ni vende productos, sino que supervisa el comportamiento de los demás usuarios y modera el contenido reportado.
 
**Gestión de usuarios:**
El administrador puede intervenir directamente sobre cualquier cuenta de usuario. Esto incluye editar sus datos o banearlo si considera que su comportamiento es inapropiado. Un usuario baneado pierde el acceso a las funcionalidades de la plataforma.
 
**Bandeja de reseñas reportadas:**
El administrador cuenta con una bandeja donde se acumulan todas las reseñas que los clientes han marcado como inapropiadas. Frente a cada reporte, el administrador puede tomar una de dos decisiones, las cuales son banear al usuario que escribió la reseña si se considera que la infracción amerita una sanción mayor, o simplemente eliminar el comentario, si basta con retirarlo de la plataforma sin necesidad de sancionar al usuario.