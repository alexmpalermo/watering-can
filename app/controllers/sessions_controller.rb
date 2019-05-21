class SessionsController < ApplicationController
  def login
    if logged_in?
      redirect_to user_path
    end 
  end

  def create
    # Get access tokens from the google server
    if access_token = request.env["omniauth.auth"]
      user = User.from_omniauth(access_token)
      log_in(user)
      # Access_token is used to authenticate request made from the rails application to the google server
      user.google_token = access_token.credentials.token
      # Refresh_token to request new access_token
      # Note: Refresh_token is only sent once during the first request
      refresh_token = access_token.credentials.refresh_token
      user.google_refresh_token = refresh_token if refresh_token.present?
      user.save
      redirect_to home_path
    else
      user = User.find_by(:email => params[:email])
      if user && user.authenticate(params[:password])
        log_in(user)
        redirect_to home_path
      else
        render '/login'
      end
    end
  end

  def destroy
  end
end
