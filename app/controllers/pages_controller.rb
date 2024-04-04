class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :show]

  def home
    @communities = Community.includes(photo_attachment: :blob).limit(10)
    @user = current_user
    if @user
      @users = User.includes(:dogs, photo_attachment: :blob).where.not(id: @user.id)
    else
      @users = User.includes(:dogs, photo_attachment: :blob)
    end
    @events = Event.includes(photo_attachment: :blob).limit(10)
  end


  def show
    @user = User.select(:id, :name, :email).find(params[:id])
  end

end
