class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    # TODO: Change this to session[:app_session_id]
    if $session_id
      @_current_user ||= DoubleDog.db.get_user_by_session_id($session_id)
    end
  end

  helper_method :current_user
end
