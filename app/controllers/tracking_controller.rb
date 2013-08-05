class TrackingController < ApplicationController

layout "auth"

before_filter :confirm_logged_in
before_filter :find_products

  def menu
    
  end

############################
  private
############################  

  def find_products
    @products = User.find_by_username(session[:username]).products
  end


end
