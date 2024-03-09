class ConversationsController < ApplicationController
  # before_action :authenticate_user

  def index
    @conversations = Conversation.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
    @over_ten = @messages.length > 10
    @messages = @messages[ -10..-1 ] if @over_ten && !params[:m]
    @messages.last&.update(read: true) if @messages.last&.user_id != current_user.id
    @message = @conversation.messages.new
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
