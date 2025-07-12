class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototype = Prototype.find(params[:prototype_id])
      @comments = @prototype.comments.includes(:user).order(created_at: :desc)
      render 'prototypes/show', status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = @prototype.comments.new
    @comments =@prototype.comments.includes(:user)
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
