class User < ApplicationRecord
   has_many :destinations
   has_many :comments 
   has_many :commented_destinations, through: :comments, source: :destination
   has_secure_password
   validates :username, :password, presence: true 
   validates_uniqueness_of :username 

  def self.create_from_github(auth)
    User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
      u.username = auth[:extra][:raw_info][:login]
      u.password = SecureRandom.hex(12)
    end
  end


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