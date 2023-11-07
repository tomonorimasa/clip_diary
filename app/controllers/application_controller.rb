class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login, :set_search
  
  private

  def not_authenticated
    flash[:warning] = 'ログインしてください'
    redirect_to login_path
  end

  def set_search
    @q_header = Board.ransack(params[:q])
    @boards = @q_header.result(distinct: true).includes(%i[user tags]).order(created_at: :desc).page(params[:page]).per(10)
  end
end
