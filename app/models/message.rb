class Message < ApplicationRecord
  belongs_to :conversation
  # Le decimos a Rails que el sender (remitente) es en realidad un usuario
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'

  # Validamos que no se puedan enviar mensajes en blanco
  validates :content, presence: true
end