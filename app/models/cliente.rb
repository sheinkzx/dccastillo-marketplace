# La clase Cliente hereda (<) de User (Respetando modelo E/R)
# por eso en la BD sabe que su 'type' es 'Cliente'

class Cliente < User
  "
  Aquí irá la lógica de compras del cliente
  (ej: agregar productos al carrito, gestionar direcciones de envío, etc.)
  "

  # Aquí puedes agregar relaciones exclusivas, como:
  # has_many :compras (Relato 17)

  # RU 25 Agregamos la relación entre cliente y la tabla favoritos
  has_many :favoritos, foreign_key: "cliente_id", dependent: :destroy
end
