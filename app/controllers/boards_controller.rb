class BoardsController < ApplicationController
  def index
    @tag = Tag.find(params[:tag_id]) if params[:tag_id].present?
    @boards = @tag.boards.includes(:user).order(created_at: :desc).page(params[:page]).per(10) if @tag
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id
    tag_list = params[:board][:tag_names].split(/,|、/)
    if @board.save
      @board.save_tag(tag_list)
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
    @tag_list = @board.tags.pluck(:name).join(',')
  end

  def update
    @board = Board.find(params[:id])
    tag_list = params[:board][:tag_names].split(/,|、/)
    if @board.update(board_params)
      @board.save_tag(tag_list)
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
    @q = current_user.like_boards.ransack(params[:q])
    @like_boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :video, :name)
  end
end
