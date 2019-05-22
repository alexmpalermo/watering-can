class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find_by_id(session[:user_id])
  end

  def logged_in_or_redirect
    if logged_in?
      @user = current_user
      redirect_to user_path(@user)
    end
  end

  def redirect_unless_logged_current
    redirect_to home_path unless logged_in? && @user == current_user
  end
end
