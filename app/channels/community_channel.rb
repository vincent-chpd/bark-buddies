class CommunityChannel < ApplicationCable::Channel
  def subscribed
    community = Community.find(params[:id])
    stream_for community
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
