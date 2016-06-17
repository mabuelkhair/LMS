class UserController < ApplicationController
  def user
  	
  end

  def profile
    authenticate_user!
   #  if current_user.nil? then 
   #   redirect_to(:controller => 'registrations' ,:action => 'sign_up')
   # end
  	@user = current_user
    @guest = false
  	puts @user
  end

  def follow
  end

  def unfollow
  end

  def guest_profile
  	@user = User.find(params[:id])
  	@guest = true
  	puts @user
  	render :profile
  end
end
