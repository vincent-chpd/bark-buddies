class CommunityMessagesController < ApplicationController

  def create
    @community = Community.find(params[:community_id])
    @community_message = CommunityMessage.new(message_params)
    @community_message.community = @community
    @community_message.user = current_user
    if @community_message.save
      CommunityChannel.broadcast_to(
        @community,
        render_to_string(partial: "community_messages/message", locals: { message: @community_message })
      )
      head :ok
    else
      render "communities/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:community_message).permit(:content)
  end
end
