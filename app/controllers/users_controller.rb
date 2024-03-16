class UsersController < ApplicationController

  def index
    if params[:query].present?
      @users = User.search_by_location_name(params[:query])
      @message = "⛔ No users available for this location ⛔ #{view_context.link_to('Go back', users_path)}" if @users.empty?
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    @dog = @user.dogs.first
    @conversations = Conversation.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
    @friendship = Friendship.find_by(receiver_id: @user.id, sender_id: current_user.id)
  end

  def update
    @user.update(user_params)
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  def upload_photos
    @dog = Dog.find(params[:id])
    params[:photos].each do |photo|
      @dog.photos.create(image: photo)
    end
    redirect_to @dog
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :age, :photo, :location, :bio)
  end
end
