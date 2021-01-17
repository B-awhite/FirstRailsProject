class User < ApplicationRecord
   has_many :destinations
   has_many :comments 
   has_many :commented_destinations, through: :comments, source: :destination
   has_secure_password
   validates :username, :password, presence: true 
   validates_uniqueness_of :username 

   # def find_or_create_by(auth)
   #    self.find_or_create_by(username: auth[:info][:uid]) do |u|
   #       u.password = SecureRandom.hex
   #    end 
   # end 

end
# @user = User.find_or_create_by(uid: auth.uid) do |u|
    #   u.username = auth.extra.raw.info.login
    #   u.password = SecureRandom.hex(12)
    # end 
    #  if @user.valid?
    #   session[:user_id] = @user.id
    #   redirect_to user_path(@user)

    # if params[:provider]
    #   @user = User.find_or_create_by(auth)
    #   session[:user_id] = @user.id
    #   redirect_to user_path(@user)
   #  else 