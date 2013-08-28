class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)  #.permit(:email, :password, :confirmed_password))
    if @user.save
      # do whatever
      flash[:notice] = "Successfully created a new user!"
    else
      flash[:notice] = @user.errors.full_messages
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end