class Producto < ApplicationRecord
  belongs_to :vendedor, class_name: "User" #* el producto le pertenece al vendedor pero la clase que alberga todo es "User"
  has_many :compras #* un producto puede tener muchas compras
  has_many :favoritos, dependent: :destroy # RU 25 Agregamos la relación con favoritos

  validates :titulo, presence: true
  validates :precio, presence: true, numericality: { greater_than: 0 }
  validates :descripcion, presence: true
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
end