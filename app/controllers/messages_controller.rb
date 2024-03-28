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
      message: render_to_string(partial: "messages/message_content", locals: { message: @message }),
      sender_id: @message.user_id,
      time: @message.created_at.strftime("%H:%M")
    )
  end

  def reach_to_notification_channel
    other_user = @conversation.sender == current_user ? @conversation.recipient : @conversation.sender

    other_total_conversations = other_user.received_conversations.or(other_user.conversations)

    # Find unread messages for the conversation between current_user and other_user
    other_user_unread_messages = Message.joins(:conversation)
                                    .where(conversations: { id: other_total_conversations })
                                    .where.not(user_id: other_user.id)
                                    .where(read: false)

    # Broadcast the conversation ID along with the unread messages count to the other_user
    NotificationChannel.broadcast_to(
      other_user,
      data: {
        unread_messages_number: other_user_unread_messages.count
      }
    )
  end

  def message_params
    params.require(:message).permit(:content, :user_id)
  end
end
