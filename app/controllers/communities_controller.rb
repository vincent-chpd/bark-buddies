class CommunitiesController < ApplicationController

  def index
    @communities = if params[:query].present?
                    Rails.cache.fetch("communities/#{params[:query]}") do
                      Community.search_by_name(params[:query])
                    end
                  else
                    Rails.cache.fetch('communities/all') do
                      Community.all
                    end
                  end
  end

  def show
    @community = Community.find(params[:id])
    @community_message = CommunityMessage.new
  end
end
