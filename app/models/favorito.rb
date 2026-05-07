class Favorito < ApplicationRecord
  belongs_to :producto
  belongs_to :cliente, class_name: "User"

  # Un cliente solo puede tener un producto en favoritos una vez
  validates :producto_id, uniqueness: { scope: :cliente_id, message: "ya está en tus favoritos" }
end