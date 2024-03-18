class CommunitiesController < ApplicationController

  def index
    @communities = Community.all
    if params[:query].present?
      @communities = Community.search_by_name(params[:query])
    else
      @communities = Community.all
    end
  end

  def show
    @community = Community.find(params[:id])
    @community_message = CommunityMessage.new
  end

  def new
  end

  def create
  end

  def destroy
  end
end
