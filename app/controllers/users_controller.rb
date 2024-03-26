class UsersController < ApplicationController

  def index
    if params[:query].present?
      @users = User.search_by_location_name(params[:query])
      @message = "No buddies at this location 😢<br/>#{view_context.link_to('Try again', users_path)}" if @users.empty?
    else
      @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    @dog = @user.dogs.first
    @conversations = Conversation.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
    @friendship = Friendship.find_by(receiver_id: @user.id, sender_id: current_user.id)
    @referer_url = request.referer
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Profile was successfully updated.'
    else
      render :edit
    end
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
