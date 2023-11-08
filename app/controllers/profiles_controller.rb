class ProfilesController < ApplicationController
  before_action :set_user,:check_guest, only: %i[edit update]

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path,success: "ユーザーを更新しました"
    else
      flash.now[:danger] = "ユーザーを更新できませんでした"
      render :edit
    end
  end

  private
  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email,:nickname,:avatar,:avatar_cash)
  end

  def check_guest
    return unless current_user.email == 'guest@example.com'
    redirect_to boards_path, warning: 'ゲストユーザーはこのアクションを実行できません。'
  end
end
