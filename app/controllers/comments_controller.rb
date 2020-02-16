class CommentsController < ApplicationController
  
  def index
    @group = Group.find(params[:group_id])
    @comment = Comment.new
    @comments = @group.comments.includes(:user)
  end

  def create
    @group = Group.find(params[:group_id])
    @comment = @group.comments.new(comment_params)
    if @comment.save
      flash[:notice]='メッセージが保存されました。'
      redirect_to group_comments_path(@group)
    else
      flash[:alert]='メッセージを入力してください。'
      render :index
    end
  end

  def show
    @comment = Comment.new
    @comments = @group.comments.includes(:user)
    # render :index
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :image).merge(user_id: current_user.id)
  end


end