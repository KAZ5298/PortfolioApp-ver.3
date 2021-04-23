class SessionsController < ApplicationController
  include SessionsHelper
  
  def new
    @user = User.new
  end
  
  def create
    email = params_user[:email]
    user = User.find_by(params[:email])
    if user && user.authenticate(params_user[:password])
      log_in(user)
      redirect_to root_url, notice: "OK"
    else
      @user = User.new(email: email)
      render :new
    end
  end
  
  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url
  end
 
  private
 
  def params_user
    params.require(:user).permit(:email, :password)
  end
end
