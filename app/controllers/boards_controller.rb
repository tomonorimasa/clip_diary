class BoardsController < ApplicationController
  def index
    @boards = Board.all.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, success: '新規作成しました'
    else
      flash.now['danger'] = '新規作成に失敗しました'
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
      redirect_to @board, success: '投稿を更新しました'
    else
      flash.now['danger'] = '投稿を更新できませんでした'
      render :edit
    end
  end

  def destroy
    @board = current_user.boards.find(params[:id])
    @board.destroy!
    redirect_to boards_path, success: '投稿を削除しました'
  end

  def likes
    @like_boards = current_user.like_boards.includes(:user).order(created_at: :desc).page(params[:page])
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :video)
  end
end
