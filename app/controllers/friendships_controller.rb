class FriendshipsController < ApplicationController

  def create
    Friendship.create(sender_id: current_user.id, receiver_id: params[:receiver_id])
    other_user = User.find(params[:receiver_id])
    flash[:notice] = "Friend request sent"

    redirect_to user_path(other_user)
  end

  def destroy
    friend = User.find(params[:id])
    Friendship.where(user_id: [current_user.id, friend.id], friend_id: [current_user.id, friend.id]).destroy_all
    flash[:notice] = "Friendship destroyed"
    redirect_to my_friends_path
  end

  def index
    @friends = current_user.friends
  end

  def show
    @friend = User.find(params[:id])
  end
end
