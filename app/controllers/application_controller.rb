class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find_by_id(session[:user_id])
  end
  
end
