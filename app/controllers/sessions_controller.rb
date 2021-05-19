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
    user = User.create_from_github(auth)
      if user.valid?
        # @user.save
          session[:user_id] = user.id
          redirect_to users_path
      else
          flash[:message] = user.errors.full_messages.join(", ")
          redirect_to login_path
      end
  end 


  # def github
  #   user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
  #     u.username = auth['extra']['raw_info']['login']
  #     u.password = SecureRandom.hex
  #   end 
  #    if user.valid?
  #     session[:user_id] = user.id
  #     redirect_to destinations_path
  #    else  
  #      flash[:message] = user.errors.full_messages.join(', ')
  #     # session[:user_id] = user.id
  #     redirect_to login_path
  #    end 
  # end 
  
  private 

  def auth 
    request.env['omniauth.auth']
  end 

  end


