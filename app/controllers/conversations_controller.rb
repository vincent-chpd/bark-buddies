class ConversationsController < ApplicationController
  # before_action :authenticate_user

  def index
    @conversations = Conversation.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
    @message = @conversation.messages.new
    @other_user = @conversation.sender_id == current_user.id ? User.find(@conversation.recipient_id) : User.find(@conversation.sender_id)
    @other_user_dog = @other_user.dogs.first
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


  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
