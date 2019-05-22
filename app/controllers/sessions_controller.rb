class SessionsController < ApplicationController
  def login
    logged_in_or_redirect
    @user = User.new
  end

  def create
    logged_in_or_redirect
    if access_token = request.env["omniauth.auth"]
      user = User.from_omniauth(access_token)
      log_in(user)
      user.google_token = access_token.credentials.token
      refresh_token = access_token.credentials.refresh_token
      user.google_refresh_token = refresh_token if refresh_token.present?
      user.save
      redirect_to user_path(user)
    else
      user = User.find_by(:email => params[:user][:email])
      if user && user.authenticate(params[:user][:password])
        log_in(user)
        redirect_to home_path
      else
        render '/login'
      end
    end
  end

  def destroy
      require_login
      session.delete(:user_id)
      flash[:notice] = "You have successfully logged out."
      redirect_to home_path
  end
end
