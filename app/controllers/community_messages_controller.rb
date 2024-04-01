class CommunityMessagesController < ApplicationController

  def create
    @community = Community.includes(:users).find(params[:community_id])
    @community_message = @community.community_messages.new(message_params)
    @community_message.user = current_user
    if @community_message.save
      CommunityChannel.broadcast_to(
        @community,
        message: render_to_string(partial: "community_messages/message_content", locals: { message: @community_message }),
        sender_id: @community_message.user_id,
        time: @community_message.created_at.strftime("%H:%M"),
        sender_name: @community_message.user.name
      )
      head :ok
    else
      render "communities/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:community_message).permit(:content, :user_id)
  end
end
