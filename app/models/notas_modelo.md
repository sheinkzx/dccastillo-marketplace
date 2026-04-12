El directorio app/models/, es el corazón de la aplicación. En Rails, los modelos son los que hablan con la base de datos y contienen las reglas de negocio.


Concepto Clave: STI (Single Table Inheritance)
Gracias a que Vendedor y Cliente tienen ese < User, Rails sabe que no tiene que buscar tablas llamadas "vendedores" o "clientes", sino que debe buscar todo en la tabla users y usar la columna type para saber quién es quién.