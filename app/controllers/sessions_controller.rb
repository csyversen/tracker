class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or products_path
    else
      flash.now[:error] = 'Invalid email/password. Please try again!'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end