class Producto < ApplicationRecord
  # def self.table_name_prefix
  #   "producto_"
  # end
  has_many :reviews, class_name: 'Producto::Review'
  belongs_to :vendedor, class_name: "User" #* el producto le pertenece al vendedor pero la clase que alberga todo es "User"
  has_many :compras #* un producto puede tener muchas compras
  has_many :favoritos, dependent: :destroy # RU 25 Agregamos la relación con favoritos

  validates :titulo, presence: { message: "es obligatorio" }
  validates :precio, presence: true, numericality: { greater_than_or_equal_to: 0, message: "debe ser mayor o igual a 0" }
  validates :descripcion, presence: { message: "es obligatoria" }
  validates :marca, presence: { message: "es obligatoria" }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0, message: "debe ser mayor o igual a 0" }
  validates :estado, inclusion: { in: %w[Activo Inactivo Agotado] } # Solo permite estos 3 estados

  # Este 'callback' se ejecuta justo antes de guardar en la base de datos
  before_save :verificar_estado_agotado

  private

  def verificar_estado_agotado
    # Si el stock es 0, obligamos a que el estado sea Agotado
    if stock <= 0
      self.estado = "Agotado"
    elsif estado == "Agotado" && stock > 0
      # Si le vuelven a poner stock a algo agotado, lo pasamos a Activo
      self.estado = "Activo"
    end
  end
  
end

#NOTA: (HU 14) 
#Agregue la columna estado a la tabla productos. Tiene el valor "Activo" por defecto para 
#los productos nuevos. El estado puede ser "Activo", "Inactivo" o "Agotado". 
# Si el stock de un producto llega a 0, su estado se actualiza automáticamente a "Agotado". 
#Si se vuelve a agregar stock a un producto agotado, su estado cambia a "Activo". 
# Esto se hace automatico, el vendedor no tiene que hacer nd en este caso. 
