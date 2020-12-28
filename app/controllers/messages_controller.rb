class MessagesController < ApplicationController
  before_action :require_user

  def create
    #message = Message.create(body: params[:message][:body], user_id: current_user.id)
    message = current_user.messages.build(message_params)
    if message.save
      #redirect_to root_path
      ActionCable.server.broadcast 'chatroom_channel', message: message_render(message)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def message_render(message)
    render(partial: 'message', locals: {  message: message })
  end
end
