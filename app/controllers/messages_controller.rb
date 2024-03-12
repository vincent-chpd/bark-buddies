class MessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)

    if @message.save
      reach_to_conversation_channel
      reach_to_notification_channel
    else
      flash[:error] = "Failed to create message"
      redirect_back fallback_location: root_path
    end
  end

  private

  def reach_to_conversation_channel
    ConversationChannel.broadcast_to(
      @conversation,
      render_to_string(partial: "messages/message", locals: { message: @message })
    )
  end

  def reach_to_notification_channel
    other_user = @conversation.sender == current_user ? @conversation.recipient : @conversation.sender
    unread_messages = other_user.messages.where(read: false)
    NotificationChannel.broadcast_to(
      other_user,
      notification_count: unread_messages.count
    )
  end

  def message_params
    params.require(:message).permit(:content, :user_id)
  end
end
