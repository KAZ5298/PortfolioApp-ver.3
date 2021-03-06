module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def current_user
    if session[:user_id].present?
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
  def logged_in?
    current_user.present?
  end
  
  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end
