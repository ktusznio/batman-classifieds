class ApplicationController < ActionController::Base
  before_filter :ensure_authenticated

  def ensure_authenticated
    if session[:user_id].blank?
      session[:redirect] = request.fullpath
      redirect_to(login_path)
    end
  end

  def current_user
    return nil unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def app
  end

  helper_method :current_user
end
