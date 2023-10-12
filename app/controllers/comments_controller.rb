class CommentsController < ApplicationController
    def create
      comment = current_user.comments.build(comment_params)
      if comment.save
        redirect_to board_path(comment.board), success: 'コメントを作成しました'
      else
        redirect_to board_path(comment.board), danger: 'コメント作成に失敗しました'
      end
    end
    
    private
    
    def comment_params
      params.require(:comment).permit(:body).merge(board_id: params[:board_id])
    end
end
