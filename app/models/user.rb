class User < ApplicationRecord
    ## NOTA: La clase usuario fue migrada a la BD solo con los campos nombre, email y password_digest, 
    # por lo que no se incluyen otros campos como apellido o rut. 


  has_secure_password # Esto permite usar password_digest para el login (que es la que encripta las 
  # contraseñas y también agrega métodos como authenticate para verificar la contraseña)
  

  # Validaciones para cumplir con los relatos 9 y 11
  validates :nombre, presence: true
  validates :email, presence: true, uniqueness: true
end