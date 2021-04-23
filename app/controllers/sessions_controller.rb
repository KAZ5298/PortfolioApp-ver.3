class SessionsController < ApplicationController
  include SessionsHelper
  
  def new
    @user = User.new
    redirect_to tweets_url if logged_in?
  end
  
  def create
    email = params_user[:email]
    user = User.find_by(params[:email])
    if user && user.authenticate(params_user[:password])
      log_in(user)
      redirect_to tweets_url, notice: "ログインしました"
    else
      @user = User.new(email: email)
      render :new
    end
  end
  
  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url, notice: "ログアウトしました"
  end
 
  private
 
  def params_user
    params.require(:user).permit(:email, :password)
  end
end
