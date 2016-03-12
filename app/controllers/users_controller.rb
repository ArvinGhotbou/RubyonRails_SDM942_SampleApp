class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    redirect_to root_url and return unless @user.activated?
  end

  def create
    @user = User.new(user_params)
      if @user.save
        #log_in @user
        #flash[:success] = "Successfully Registered. Welcome to the Sample App!"
        #redirect_to @user
        @user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_url
      else
        render 'new'
      end
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
    def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation)
    end
    
  public  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
    if @user != current_user
      flash[:danger] = "Access Denied."
    end
  end
  
  def destroy
    @temp_user = User.find(params[:id])
    User.find(params[:id]).destroy
    flash[:success] = @temp_user.name + " deleted"
    redirect_to users_url
  end
  
  private
  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
  
  public
  # resend activation mail
  def reacma
    @user = User.new
  end
  
  def resend
    @user = User.find_by(email: params[:user][:email].downcase)
    
    if @user && @user.authenticate(params[:user][:password])
      if @user.activated?
        flash[:success] = 'Your Account is Active'
        log_in @user
        redirect_to root_url
      else
       @user.create_activation_digest
       @user.update_attributes(activation_digest: @user.activation_digest)
       @user.send_activation_email
       flash[:info] = 'Activation Link Sent to You Email Again.'
       redirect_to root_url
      end
    else
      flash[:danger] = 'Invalid email/password combination or no User'
      redirect_to reacma_path
    end


  end
  
end
