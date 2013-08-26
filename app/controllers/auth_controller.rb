class AuthController < ApplicationController

  #layout "auth"

  def index
    render("login")
  end


  def login
  end


  def new
    #@user = User.new
  end


  def create
    @user = User.new(params[:user].permit(:username, :password, :email))
    if @user.save
      flash[:notice] = "You have successfully created a user!"
      redirect_to(:action => "login")
    else
      flash[:notice] = "There was an issue saving your user"
      @user.errors.full_messages.each do |msg|
        puts msg
      end
      render("new")
    end
  end


  def attempt_login
    authorized_user = User.authenticate(params[:username], params[:password])
    if authorized_user
      # TODO mark user as logged in
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      flash[:notice] = "You have successfully logged in"
      flash[:flash_class] = "alert alert-success" #TODO: create a constant to replace this 
      redirect_to(:controller => "tracking", :action => "menu")
    else
      flash[:notice] = "Invalid username or password"
      flash[:flash_class] = "alert alert-danger"
      redirect_to(:action => "login")
    end
  end


  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "You have logged out"
    flash[:flash_class] = "alert alert-success"
    redirect_to(:action => "login")
  end

end
