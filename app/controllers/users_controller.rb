class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end


  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)  #.permit(:email, :password, :confirmed_password))
    if @user.save
      sign_in @user
      flash[:success] = "Successfully created a new user!"
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @products = @user.products.paginate(page: params[:page])
  end


  def edit 
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      sign_in @user
      flash[:success] = "Successfully edited the user!"
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages
      render 'edit'
    end
  end

####################################################
  private
####################################################

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def signed_in_user
    unless logged_in?
      store_location
      redirect_to login_url, notice: "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
