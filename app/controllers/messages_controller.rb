class MessagesController < ApplicationController
  before_action :require_login

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.sender = current_user

    if @message.save
      redirect_to conversation_path(@conversation)
    else
      redirect_to conversation_path(@conversation), alert: "El mensaje no puede estar vacío."
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end