class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or user_path(@user)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
    
  end
  
  def destroy
    if logged_in?
      log_out
      flash[:success] = "Successfully Logged Out"
    else
      flash[:danger] = "You Were Logged Out Previously"
    end
    redirect_to root_url
  end
end