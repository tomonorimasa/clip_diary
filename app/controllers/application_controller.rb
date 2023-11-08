class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login, :set_search
  
  private

  def not_authenticated
    if current_user.nil?
      user = User.find_by(email: 'guest@example.com')
      auto_login(user) if user
      redirect_to boards_path, success: 'ゲストユーザーとしてログインしました。'
    else
      flash[:warning] = 'ログインしてください'
      redirect_to login_path
    end
  end

  def set_search
    @q_header = Board.ransack(params[:q])
    @boards = @q_header.result(distinct: true).includes(%i[user tags]).order(created_at: :desc).page(params[:page]).per(10)
  end
end
