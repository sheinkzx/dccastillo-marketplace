class Producto::Review < ApplicationRecord
  belongs_to :producto  
  belongs_to :user

  validates :puntaje, numericality: { in: 1..5 }
end