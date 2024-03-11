class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :show ]

  def home
    @communities = Community.all
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
