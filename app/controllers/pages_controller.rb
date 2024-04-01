class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :show, :landing]
  before_action :load_data, only: [:home]

  def home
    # Use instance variables set by before_action
  end

  def show
    @user = User.select(:id, :name, :email).find(params[:id])
  end

  def landing
  end

  private

  def load_data
    @communities = Community.limit(10) # Limit the number of communities fetched
    @users = User.limit(10) # Limit the number of users fetched
    @user = current_user
    @events = Event.limit(10) # Limit the number of events fetched
  end
end
