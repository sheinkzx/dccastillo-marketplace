
# Aquí irá la lógica de la tienda del vendedor


# La clase Vendedor hereda (<) de User
class Vendedor < User
  # El vendedor tiene una relación exclusiva con su tienda (Relato 11)
  has_one :store, dependent: :destroy 
end