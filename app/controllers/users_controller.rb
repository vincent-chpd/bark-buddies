class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def query
    @users = User.where("name ILIKE ?", "%#{params[:query]}%")
  end

  def show
  end

  def update
    @user.update(user_params)
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :age, :photo, :location, :bio)
  end
end
