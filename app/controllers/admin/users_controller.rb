class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[edit update show destroy]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), success: 'ユーザー情報を更新しました。'
    else
      flash.now['danger'] = 'ユーザ情報の更新に失敗しました。'
      render :edit
    end
  end

  def show; end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, success: 'ユーザーを削除しました。'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :nickname, :avatar, :avatar_cache, :role)
  end
end
