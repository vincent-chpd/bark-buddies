class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      sql_query = " \
        users.name ILIKE :query \
        OR users.age ILIKE :query \
        OR users.location ILIKE :query \
        OR users.email ILIKE :query \
        OR users.dog.breed ILIKE :query \
      "
      @movies = User.joins(:dog).where(sql_query, query: "%#{params[:query]}%")
    else
      @movies = Movie.all
    end
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
