class SessionsController < ApplicationController
  
  def destroy
    session.clear
    redirect_to root_path
  end 
  
  def create
       user = User.find_by(username: params[:user][:username])
       if user && user.authenticate(params[:user][:password])
         session[:user_id] = user.id 
         redirect_to user_path(user)
      else 
         flash[:message] = "Incorrect username or password, please try again"
         redirect_to '/login'
      end  
  end 

  def github
    binding.pry
    @user = User.find_or_create_by(username: auth.uid) do |u|
      u.username = auth.extra.raw.info.login
      u.password = SecureRandom.hex(12)
    end 
     if @user.valid?
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    #  end 
    end 
    @user = User.find_or_create_by(auth)
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end 
  
  private 

  def auth 
    request.env['omniauth.auth']
  end 

  end


