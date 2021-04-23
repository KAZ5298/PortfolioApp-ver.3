class RegistrationsController < ApplicationController
  include SessionsHelper
  
  def new
    @user = User.new
    redirect_to tweets_url if logged_in?
  end
  
  def create
    @user = User.new(params_user)
 
    if @user.save
      log_in(@user)
      redirect_to tweets_url, notice: "新規登録しました"
    else
      render :new
    end
  end
 
  private
  
  def params_user
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end