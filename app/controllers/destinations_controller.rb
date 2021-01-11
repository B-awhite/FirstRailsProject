class DestinationsController < ApplicationController
   before_action :if_not_logged_in_redirect

   def new 
      @destination = Destination.new
   end 

   def create
      @destination = current_user.destinations.build(destination_params)
      if @destination.save 
         redirect_to destinations_path 
      else 
         render :new 
      end 
   end 

   private 

   def destination_params
      params.require(:destination).permit(:location, :city)
   end 
end
