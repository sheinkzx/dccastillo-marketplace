
# La clase Vendedor hereda (<) de User (nombre, email, etc.)
#  por eso en la BD sabe que su 'type' es 'Vendedor'
class Vendedor < User
  """Aquí irá la lógica de la tienda del vendedor, como agregar productos, gestionar stock, etc."""

  # El vendedor tiene una relación exclusiva con su tienda (Relato 11)
  has_one :store, dependent: :destroy # Indica que un Vendedor tiene 1 Tienda. 
                                      # 'dependent: :destroy' significa que si borras al vendedor, su tienda se borra también.
end