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
        user_id: current_user.id,
      )
      render :show
    else
      render json: { message: "User must be logged in" }
    end
  end

  def update
    @dog = Dog.find_by(id: params[:id])

    if current_user.id == @dog.user_id
      @dog.name = params[:name] || @dog.name
      @dog.age = params[:age] || @dog.age
      @dog.breed = params[:breed] || @dog.breed
      @dog.save
      if @dog.valid?
        render template: "dogs/show"
      else
        render json: { errors: @dog.errors.full_messages }
      end
    else
      render json: { message: "not your dog" }
    end
  end

  def destroy
    @dog = Dog.find_by(id: params[:id])

    if current_user.id == @dog.user_id
      @dog.destroy
      render json: { message: "dog is deleted" }
    else
      render json: { message: "can't delete dog that isn't yours" }
    end
  end
end
