class ConversationsController < ApplicationController
  # before_action :authenticate_user

  def index
    @conversations = Conversation.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
    respond_to do |format|
      format.html
      format.text { render partial: "conversations/conversations_card", locals: { conversations: @conversations } }
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
    @message = @conversation.messages.new
    @other_user = @conversation.sender_id == current_user.id ? User.find(@conversation.recipient_id) : User.find(@conversation.sender_id)
    @other_user_dog = @other_user.dogs.first
  end

  def update_read_status
    @conversation = Conversation.find(params[:id])
    # all the messages wich are not sent by the current user and are unread
    @messages = @conversation.messages.where.not(user_id: current_user.id).where(read: false)
    @messages.update_all(read: true)

    respond_to do |format|
      format.json { render json: { status: :ok } }
    end
  end

  def create
    existing_conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first

    if existing_conversation.present?
      redirect_to conversation_path(existing_conversation)
    else
      @conversation = Conversation.new(conversation_params)
      if @conversation.save
        redirect_to conversation_path(@conversation)
      else
        flash[:error] = "Failed to create conversation"
        redirect_back fallback_location: root_path
      end
    end
  end

  def destroy
    @conversation = Conversation.find(params[:id])
    @conversation.destroy
    redirect_to conversations_path
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def reach_to_notification_channel
    # other_user = @conversation.sender == current_user ? @conversation.recipient : @conversation.sender

    # Find unread messages for the conversation between current_user and other_user
    my_unread_messages = @conversation.messages.where.not(user_id: current_user.id).where(read: false)

    # Broadcast the conversation ID along with the unread messages count to the other_user
    NotificationChannel.broadcast_to(
      current_user,
      data: {
        unread_messages_number: my_unread_messages.count
      }
    )
  end
end
