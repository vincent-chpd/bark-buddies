class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :show]

  def home
    @communities = Community.includes(photo_attachment: :blob).limit(10)
    @users = User.includes(:dogs, photo_attachment: :blob).where.not(id: current_user.id)
    @user = current_user
    @events = Event.includes(photo_attachment: :blob).limit(10)
  end

  def show
    @user = User.select(:id, :name, :email).find(params[:id])
  end

end
