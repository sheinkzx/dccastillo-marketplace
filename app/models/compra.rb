class Compra < ApplicationRecord
  belongs_to :producto
  belongs_to :cliente, class_name: "User"
  #TODO: borrar esta relación innecesaria y no acordada
  belongs_to :vendedor, class_name: "User"

  #* El estado solo puede ser pendiente o aprobado
  validates :estado, inclusion: { in: %w[pendiente aprobado] }
end