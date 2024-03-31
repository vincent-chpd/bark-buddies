class FriendshipsController < ApplicationController

  def create
    Friendship.create(sender_id: current_user.id, receiver_id: params[:receiver_id])
    other_user = User.find(params[:receiver_id])

    redirect_to user_path(other_user)
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    other_user = User.find(params[:receiver_id])
    @friendship.destroy
    redirect_to user_path(other_user)
  end

  def index
    @friends = current_user.friends
  end

  def show
    @friend = User.find(params[:id])
  end
end
