class CommentsController < ApplicationController
  
  def index
    @group = Group.find(params[:group_id])
    @comment = Comment.new
    @comments = @group.comments.includes(:user)
  end

  def create
    @group = Group.find(params[:group_id])
    @comment = @group.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.json
      else
        format.json
      end
    end

  end

  def show
    @comment = Comment.new
    @comments = @group.comments.includes(:user)
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :image).merge(user_id: current_user.id)
  end


end