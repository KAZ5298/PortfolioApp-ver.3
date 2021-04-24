class SettingsController < ApplicationController
  include SessionsHelper
  
  def edit
    unless logged_in?
      redirect_to new_sessions_path, notice: "ログインしてください"
    else
      @user = current_user
    end
  end
 
  def update
    @user = current_user
    @user.assign_attributes(params_user)
    if @user.save
      redirect_to user_url(@user), notice: "プロフィールを更新しました"
    else
      render :edit, notice: "プロフィールの更新に失敗しました"
    end
    
  end
 
  private
 
  def params_user
    params.require(:user).permit(:name, :screen_name, :bio)
  end
end
