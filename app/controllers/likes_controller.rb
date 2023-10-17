class LikesController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    current_user.like(@board)
  end

  def destroy
    @board = current_user.likes.find(params[:id]).board
    current_user.unlike(@board)
  end
end
