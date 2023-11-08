class LikesController < ApplicationController
  before_action :check_guest, only: [:create, :destroy]

  def create
    @board = Board.find(params[:board_id])
    current_user.like(@board)
  end

  def destroy
    @board = current_user.likes.find(params[:id]).board
    current_user.unlike(@board)
  end

  def check_guest
    return unless current_user.email == 'guest@example.com'
    redirect_to boards_path, warning: 'ゲストユーザーはこのアクションを実行できません。'
  end
end
