class Producto < ApplicationRecord
  # def self.table_name_prefix
  #   "producto_"
  # end
  has_many :reviews, class_name: 'Producto::Review'
end
