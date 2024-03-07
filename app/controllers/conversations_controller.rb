class ConversationsController < ApplicationController
  # before_action :authenticate_user

  def index
    @users = User.all
    @conversations = Conversation.all
  end

  def create
    @conversation = Conversation.new(conversation_params)
    existing_conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first

    if existing_conversation.present?
      @conversation = existing_conversation
    else
      @conversation.save!  # Use save! to raise an exception if validation fails
    end


    redirect_to conversation_messages_path(@conversation)
  rescue ActiveRecord::RecordInvalid => e
    flash[:error] = "Failed to create conversation: #{e.message}"
    redirect_back fallback_location: root_path
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
