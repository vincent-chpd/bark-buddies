class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :show, :landing ]

  def home
    @communities = Community.all
    @users = User.all
    @user = current_user
    @events = Event.all
  end

  def show
    @user = User.find(params[:id])
  end

  def landing
  end
end
