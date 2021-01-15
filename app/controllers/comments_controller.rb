class CommentsController < ApplicationController
   before_action :if_not_logged_in_redirect
   
   def index 
    if params[:destination_id] && @destination = Destination.find_by_id(params[:destination_id])
      @comments = @destination.comments
    else 
      @error = "Destination not found" if params[:destination_id]
      @comments = Comment.all 
    end 
   end  

   def new 
    if params[:destination_id] && @destination = Destination.find_by_id(params[:destination_id])
        @comment = @destination.comments.build
    else 
       @error = "Destination not found" if params[:destination_id]
       @comment = Comment.new
    end 
   end 
  
   def create
     @comment = current_user.comments.build(comment_params)
     if @comment.save 
        redirect_to comments_path 
     else 
        render :new 
     end 
   end 

   def show 
    @comment = Comment.find_by(id: params[:id])
   end 

   def edit 
    @comment = Comment.find_by(id: params[:id])
   end 

   def update 
     @comment = Comment.find_by(id: params[:id])
     if @comment.update(comment_params)
        redirect_to comment_path(@comment)
     else 
        render :edit
     end 
   end 

  
   private 
  
    def comment_params
      params.require(:comment).permit(:location, :destination_id)
    end

end
