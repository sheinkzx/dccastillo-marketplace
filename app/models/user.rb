class User < ApplicationRecord # Hereda de ApplicationRecord (la clase con la gema que conecta con la base de datos)
  """
  Este es el Modelo Padre. Aquí definí todo lo que tienen en común 
  Clientes, Vendedores y Administradores. Que por ahora es solo el nombre, email y password_digest,
  por lo que de momento no se incluyen otros campos como apellido o rut. 
  """


  has_secure_password # Línea mágica de Rails/BCrypt. Hace 3 cosas:
                      # 1. Encripta la clave en la columna 'password_digest'.
                      # 2. Me da el método 'authenticate' para el login.
                      # 3. Obliga a que el campo 'password' esté presente al crear.
  

  # Validaciones: Reglas para que no entre "basura" a la BD
  validates :nombre, presence: true # El nombre no puede estar vacío
  validates :email, presence: true, uniqueness: true # El email es obligatorio y no puede haber dos iguales
end