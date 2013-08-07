require 'uri/http'

class TrackingController < ApplicationController


before_filter :confirm_logged_in


  def menu
    @products = User.find_by_username(session[:username]).products
  end

  def create
    uri = URI.parse(params[:product][:url])
    domain = PublicSuffix.parse(uri.host) 

    @product = Product.new(:url => uri)
    @product.users << User.find(session[:user_id])
    @product.sale_site = domain.domain
    if @product.save
      flash[:notice] = "You are now tracking a new product!"
      flash[:flash_class] = "alert alert-success"
      redirect_to(:action => "menu")
    else
      flash[:notice] = "We weren't able to track that product, try using another url?"
      flash[:flash_class] = "alert alert-danger"
      @product.errors.full_messages.each do |msg|
        puts msg
      end
      redirect_to(:action => "menu")
    end

    # use nokogiri to grab the product name out of the metadata tags for amazon


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

  #def find_products
  #  @products = User.find_by_username(session[:username]).products
  #end


end
