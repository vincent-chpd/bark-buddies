class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages
    @over_ten = @messages.length > 10
    @messages = @messages[-10..-1] if @over_ten && !params[:m]
    @messages.last&.update(read: true) if @messages.last&.user_id != current_user.id
    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  def create

    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    else
      flash[:error] = "Failed to create message"
      redirect_back fallback_location: root_path
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id)
  end
end
