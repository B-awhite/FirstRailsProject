class DestinationsController < ApplicationController
   before_action :if_not_logged_in_redirect

   def new 
     if params[:user_id] && @user = User.find_by_id(params[:user_id])
       @destination = @user.destinations.build 
     else 
       @destination = Destination.new
     end 
   end 

   def index
      if params[:user_id] && @user = User.find_by_id(params[:user_id])
         @destinations = @user.destinations.alpha
      else 
        @error = "User not found"
        @destinations = Destination.alpha
      end 
   end 

   def create
      @destination = current_user.destinations.build(destination_params)
      if @destination.save 
         redirect_to destinations_path 
      else 
         render :new 
      end 
   end 

   def index
     if params[:user_id] && @user = User.find_by_id(params[:user_id])
        @destinations = @user.destinations
     else 
        @error = "Destination not found" if params[:user_id]
        @destinations = Destination.all 
     end 
   end  

   def show 
      @destination = Destination.find_by_id(params[:id])
      redirect_to destinations_path if !@destination
   end

   private 

   def destination_params
      params.require(:destination).permit(:location, :city)
   end 
end
