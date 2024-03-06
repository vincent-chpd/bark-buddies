class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :update, :destroy]

  def new
    @dog = Dog.new
  end

  def create
    @user = current_user
    @dog = Dog.new(dog_params)
    @dog.user = @user

    # if @dog.save
    #   render :show, status: :created
    # else
    #   render , status: :unprocessable_entity
    # end
  end

  def show
  end

  def update
    @dog.update(dog_params)
  end

  def destroy
    @user = current_user
    @dog.destroy
    redirect_to user_path(@user)
  end

  private

  def set_dog
    @dog = Dog.find(params[:id])
  end

  def dog_params
    params.require(:dog).permit(:name, :breed, :age, :gender, :bio)
  end
end
