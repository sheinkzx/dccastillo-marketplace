class User < ApplicationRecord # Hereda de ApplicationRecord (la clase con la gema que conecta con la base de datos)
  """
  Este es el Modelo Padre. Aquí definí todo lo que tienen en común 
  Clientes, Vendedores y Administradores. Que por ahora es solo el nombre, email y password,
  por lo que de momento no se incluyen otros campos como apellido o rut. 
  """


  has_secure_password # Línea mágica de Rails/BCrypt. Hace 3 cosas:
                      # 1. Encripta la clave en la columna 'password_digest'.
                      # 2. Me da el método 'authenticate' para el login.
                      # 3. Obliga a que el campo 'password' esté presente al crear.
  

  # Validaciones: Reglas para que no entre "basura" a la BD

  # El nombre no puede estar vacío
  validates :nombre, presence: true 

  # El email es obligatorio y no puede haber dos iguales. Ademas, el formato debe validar que tenga un @ y un .com (o similar).
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  
  # La contraseña no permite claves de 1 solo caracter
  validates :password, length: { minimum: 6 }, allow_nil: true
  # Ademas, es allow_nil: true (permite nulos) para que no te obligue a escribir la contraseña de nuevo si 
  # solo quieres cambiar el nombre o email. (esto no significa que puedas crear un usuario sin contraseña, 
  # porque 'has_secure_password' ya lo prohíbe)

  end