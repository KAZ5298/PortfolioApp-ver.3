class SettingsController < ApplicationController
  include SessionsHelper
  
  def edit
    @user = current_user
  end
 
  def update
    #@user = current_user.assign_attributes(params_user)
    @user = User.find(params[:id])
    if @user.update(params_user)
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
