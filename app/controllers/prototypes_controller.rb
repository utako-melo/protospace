class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]

  def index
    @prototypes = Prototype.all
  end
 
  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[ :id])
    @comment = Comment.new(prototype_id: @prototype.id)
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[ :id])
    unless @prototype.user == current_user
      redirect_to root_path
    end
  end

  def update
    if prototype = Prototype.find(params[ :id])
      prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    prototype = Prototype.find(params[ :id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch, :concept, :image).merge(user_id: current_user.id)
  end 
end
