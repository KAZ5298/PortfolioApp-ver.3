class RegistrationsController < ApplicationController
  include SessionsHelper
  
  def new
    @user = User.new
    redirect_to tweets_url if logged_in?
  end
  
  def create
    @user = User.new(params_user)
 
    if @user.save
      #会員登録後、ログインするように
      redirect_to tweets_url
    else
      render :new
    end
  end
 
  private
 
  def params_user
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end