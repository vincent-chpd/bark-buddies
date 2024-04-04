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
    @communities = Community.includes(photo_attachment: :blob).limit(10) # Limit the number of communities fetched
    @users = User.includes(:dogs, photo_attachment: :blob).limit(10) # Limit the number of users fetched
    @user = current_user
    @events = Event.includes(photo_attachment: :blob).limit(10) # Limit the number of events fetched
  end
end
