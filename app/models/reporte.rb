class Reporte < ApplicationRecord
  belongs_to :producto_review, class_name: "Producto::Review"
  belongs_to :cliente, class_name: "User"

  MOTIVOS = [
    "Información falsa o engañosa",
    "Lenguaje ofensivo o acoso",
    "Contenido inapropiado o spam",
    "Suplantación de identidad",
    "No tiene relación con el producto",
    "Otro motivo"
  ].freeze

  ESTADOS = %w[pendiente resuelto ignorado].freeze

  validates :motivo, inclusion: { in: MOTIVOS }
  validates :estado, inclusion: { in: ESTADOS }

  scope :pendientes, -> { where(estado: "pendiente") }
  scope :recientes,  -> { order(created_at: :desc) }
end