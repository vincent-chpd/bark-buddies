class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :update, :destroy]
  before_action :set_user, only: [:create, :destroy]

  def new
    @dog = Dog.new
  end

  def create
    @dog = @user.dogs.build(dog_params)

    if @dog.save
      render :show, status: :created
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    @dog.update(dog_params)
  end

  def destroy
    @dog.destroy
    redirect_to user_path(@user)
  end

  private

  def set_dog
    @dog = Dog.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def dog_params
    params.require(:dog).permit(:name, :breed, :age, :gender, :bio, photos: [])
  end
end
