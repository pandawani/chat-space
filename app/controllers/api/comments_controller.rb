class Api::CommentsController<ApplicationController
  def index
    # binding.pry
    group = Group.find(params[:group_id])
    last_comment_id = params[:id].to_i
    @comments = group.comments.includes(:user).where("id>?", last_comment_id)
  end
end