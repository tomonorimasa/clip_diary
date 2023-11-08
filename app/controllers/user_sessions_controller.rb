class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end
  
  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to boards_path, success: 'ログインしました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to root_path, success: 'ログアウトしました'
  end

  def guest_login
    if current_user.nil?
      user = User.find_by(email: 'guest@example.com')

      if user.nil?
        user = User.create(email: 'guest@example.com', password: SecureRandom.hex)
      end

      auto_login(user)  # ゲストユーザーをログイン

      redirect_to boards_path, notice: 'ゲストユーザーとしてログインしました。'
    else
      redirect_to boards_path, notice: 'すでにゲストユーザーとしてログインしています。'
    end
  end
end