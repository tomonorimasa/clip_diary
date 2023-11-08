class CommentsController < ApplicationController
  before_action :check_guest, only: [:create, :destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end
    
  private
    
  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end

  def check_guest
    return unless current_user.email == 'guest@example.com'
    redirect_to boards_path, warning: 'ゲストユーザーはこのアクションを実行できません。'
  end
end
