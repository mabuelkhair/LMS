class UserController < ApplicationController
  respond_to :html, :json
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
    if !current_user.nil? then
      if params[:id] == current_user.id then
        redirect_to(:controller => 'user', :action => 'profile')
      end
    else
      @guest = true
    end
  	puts @user
  	render :profile
  end

  def update
    @user = User.find params[:id]

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.json { respond_with_bip(@user) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@user) }
      end
    end
  end

  private
  def user_params
    params.require(:user).permit!
  end

end
