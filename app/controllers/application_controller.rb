class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  def current_user
    if session[:user_id]
      begin
        @current_user = User.find(session[:user_id])
      rescue ArgumentError
        session[:user_id] = :nil
      end
    end

    @current_user
  end
end
