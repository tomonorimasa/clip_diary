class Admin::BoardsController < Admin::BaseController
  before_action :set_board, only: %i[edit update show destroy]
  
  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end
  
  def edit; end
  
  def update
    if @board.update(board_params)
      redirect_to admin_board_path(@board), success: 'クリップを更新しました。'
    else
      flash.now['danger'] = 'クリップの更新に失敗しました。'
      render :edit
    end
  end
  
  def show; end
  
  def destroy
    @board.destroy!
    redirect_to admin_boards_path, success: 'クリップを削除しました。'
  end
  
  private
  
  def set_board
    @board = Board.find(params[:id])
  end
  
    def board_params
      params.require(:board).permit(:title, :body, :video)
    end
  end
