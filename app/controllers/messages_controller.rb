class MessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)

    if @message.save
      ConversationChannel.broadcast_to(
        @conversation,
        render_to_string(partial: "messages/message", locals: { message: @message })
      )
      # redirect_to conversation_path(@conversation)
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
