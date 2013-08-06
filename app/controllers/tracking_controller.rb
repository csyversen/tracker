require 'uri/http'

class TrackingController < ApplicationController


before_filter :confirm_logged_in
before_filter :find_products

  def menu
    
  end

  def create
    uri = URI.parse(params[:product][:url])
    domain = PublicSuffixList.parse(uri.host) 

    @product = Product.new(:url => uri)

    @product.sale_site = domain.domain


    #if @user.save
    #  flash[:notice] = "You have successfully created a user!"
    #  redirect_to(:action => "login")
    #else
    #  flash[:notice] = "There was an issue saving your user"
    #  @user.errors.full_messages.each do |msg|
    #    puts msg
    #  end
    #  render("new")
    #end
  end

############################
  private
############################  

  def find_products
    @products = User.find_by_username(session[:username]).products
  end


end
