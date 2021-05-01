module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include SessionsHelper
    
    def connect
      self.current_user = find_verified_user
    end
    
    protected
    
    def find_verified_user
      verified_user = User.find_by(id: current_user.id)
      return reject_unauthorized_connection unless verified_user
      verified_user
    end
    
    def session
      cookies.encrypted[Rails.application.config.session_options[:key]]
    end
  end
end
