class DestinationsController < ApplicationController
   before_action :if_not_logged_in_redirect
   before_action :destination_search, only: [:show, :edit, :update]
   before_action :destination_writer?, only: [:edit, :update]

   def new 
     if params[:user_id] && @user = User.find_by_id(params[:user_id])
       @destination = @user.destinations.build 
     else 
       @destination = Destination.new
     end 
   end 

  #  def index
  #     if params[:user_id] && @user = User.find_by_id(params[:user_id])
  #        @destinations = @user.destinations.alpha
  #     else 
  #       @error = "User not found"
  #       @destinations = Destination.alpha if params[:user_id]
  #     end 
  #  end 

  def index
    if params[:user_id] && @user = User.find_by_id(params[:user_id])
       @destinations = @user.destinations
    else 
       @error = "Destination not found" if params[:user_id]
       @destinations = Destination.alpha 
    end 
  end  

   def create
      @destination = current_user.destinations.build(destination_params)
      if @destination.save 
         redirect_to destination_path(@destination) 
      else 
         render :new 
      end 
   end 

  #   def index
  #    if params[:user_id] && @user = User.find_by_id(params[:user_id])
  #       @destinations = @user.destinations
  #    else 
  #       @error = "Destination not found" if params[:user_id]
  #       @destinations = Destination.alpha 
  #    end 
  #  end  


   def show 
   end

   def edit
   end
  
    def update
      if @destination.update(destination_params)
        redirect_to destination_path(@destination)
      else
        render :edit
      end
    end

   private 

   def destination_params
      params.require(:destination).permit(:location, :city)
   end 

   def destination_search
      @destination = Destination.find_by(id: params[:id])
      if !@destination
        flash[:message] = "Destination not found"
        redirect_to destinations_path 
      end 
    end

    def destination_writer?
      redirect_to destinations_path if @destination.user != current_user
    end 

end
