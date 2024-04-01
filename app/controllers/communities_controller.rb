class CommunitiesController < ApplicationController

  def index
    if params[:query].present?
      @communities = Community.search_by_name(params[:query])
    else
      @communities = Community.includes(photo_attachment: :blob).all
    end
  end

  def show
    @community = Community.find(params[:id])
    @community_message = CommunityMessage.new
  end
end
