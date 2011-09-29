class SessionsController < ApplicationController
  skip_before_filter :ensure_authenticated, :except => :current
  respond_to :json, :html
  def new
    redirect_to '/auth/github'
  end

  def create
    if auth = request.env['omniauth.auth']
      user = User.find_or_initialize_by_uid(auth['uid'].to_s)
      user.first_name, user.last_name = auth['user_info']['name'].split(" ")
      user.email = auth['user_info']['email']
      user.save
      session[:user_id] = user.id
      redirect_to session[:redirect] || '/'
    end
  end

  def current
    respond_with current_user
  end
  def failure
  end
end
