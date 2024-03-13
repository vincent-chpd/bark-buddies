class CommunitiesController < ApplicationController

  def index
    @communities = Community.all
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
