class AuthController < ApplicationController


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
    @user.save
    redirect_to(:action => "login")
  end


  def attempt_login
    #authorized_user = AdminUser.authenticate(params[:username], params[:password])
    #if authorized_user
      # TODO mark user as logged in
    #  session[:user_id] = authorized_user.id
    #  session[:username] = authorized_user.username
      flash[:notice] = "You have successfully logged in"
      redirect_to(:controller => "tracking", :action => "menu")
    #else
    #  flash[:notice] = "Invalid username or password"
    #  redirect_to(:action => "login")
    #end
  end


  def logout
  end

end
