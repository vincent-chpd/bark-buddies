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
    # other_user_unread_messages = All the mesages in a conversation where the user_id is not the other_user and the read is false
    other_user_unread_messages = @conversation.messages.where.not(user_id: other_user.id).where(read: false)
    other_user_converations = Conversation.where(sender_id: other_user.id).or(Conversation.where(recipient_id: other_user.id))
    other_user_conversations_and_last_messages = other_user_converations.map do |conversation|
      { conversation_data: conversation, last_message: conversation.messages.last }
    end
    other_user_converations.each do |conversation|
    NotificationChannel.broadcast_to(
      other_user,
      render_to_string(partial: "conversations/new_received_conversation_card", locals: { conversation: conversation })
    )
    end
  end

  def message_params
    params.require(:message).permit(:content, :user_id)
  end
end
