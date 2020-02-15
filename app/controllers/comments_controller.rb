class CommentsController < ApplicationController
  
  def index
    @group = Group.find(params[:group_id])
    @comment = Comment.new
    @comments = @group.comments.includes(:user)
  end

  # def create
  #   @comment = Coment.create(comment_params)
  #   redirect_to "/groups/#{comment.group.id}"
  # end

  # private
  # def comment_params
  #   params.require(:comment).permit(:text).merge(user_id: current_user.id, group_id: params[:group_id])
  # end


end