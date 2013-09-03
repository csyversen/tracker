class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

###############################################
  protected
###############################################

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      flash[:flash_class] = "alert alert-danger"
      redirect_to(:controller => "auth", :action => "login")
      return false # halts the before_filter
    else
      return true
    end
  end


end
