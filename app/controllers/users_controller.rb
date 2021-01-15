class UsersController < ApplicationController

  def new 
    @user = User.new
  end 

  def create
    @user = User.new(user_params)
    if params[:user][:username].empty? || params[:user][:password].empty?
      @error = "Username and password must be filled"
      render :new
    else 
      if @user.save
        session[:user_id] = @user.id 
        redirect_to @user
      else 
        @error = "Username not available"
        render :new
      end
    end 
  end 

  def show
    if_not_logged_in_redirect
    @user = User.find_by_id(params[:id])
    redirect_to '/' if !@user
  end 

  private 

  def user_params 
    params.require(:user).permit(:username, :password)
  end

end
