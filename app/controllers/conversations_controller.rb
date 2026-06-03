class ConversationsController < ApplicationController
  before_action :require_login

  # Bandeja de mensajes (Mis Chats)
  def index
    @conversations = Conversation.where("cliente_id = ? OR vendedor_id = ?", current_user.id, current_user.id)
  end

  # Vista de un chat en específico
  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages.order(created_at: :asc)
    @new_message = Message.new
  end

  # Crear un chat nuevo desde un producto
  def create
    producto = Producto.find(params[:producto_id])
    
    # Busca si el cliente y vendedor ya tienen un chat sobre este producto, si no, lo crea
    @conversation = Conversation.find_or_create_by(
      producto_id: producto.id,
      cliente_id: current_user.id,
      vendedor_id: producto.vendedor_id
    )

    redirect_to conversation_path(@conversation)
  end
end