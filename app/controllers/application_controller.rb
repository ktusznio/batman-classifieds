class ApplicationController < ActionController::Base
  before_filter :ensure_authenticated
  before_filter :set_locale

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


  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_batman_header || extract_locale_from_accept_language_header  || I18n.default_locale
    logger.debug I18n.locale
  end

  helper_method :current_user

  private

  def extract_locale_from_batman_header
    request.env['X-BATMAN-LOCALE']
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
