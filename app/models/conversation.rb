class Conversation < ApplicationRecord
  belongs_to :producto
  # Le decimos a Rails que el cliente y el vendedor son en realidad usuarios
  belongs_to :cliente, class_name: 'User', foreign_key: 'cliente_id'
  belongs_to :vendedor, class_name: 'User', foreign_key: 'vendedor_id'
  
  # Si se borra la conversación, se borran sus mensajes
  has_many :messages, dependent: :destroy
end