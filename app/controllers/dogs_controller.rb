class DogsController < ApplicationController
  def index
    @dogs = Dog.all
    render :index
  end

  def show
    @dog = Dog.find_by(id: params[:id])
    render :show
  end

  def create
    if current_user
      @dog = Dog.create(
        name: params[:name],
        age: params[:age],
        breed: params[:breed],
      )
      render :show
    else
      render json: { message: "User must be logged in" }
    end
  end
end
