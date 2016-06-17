class UserController < ApplicationController
  respond_to :html, :json
  def user
  	
  end

  def profile
    authenticate_user!
  	@user = current_user
    @guest = false
  	puts @user
  end

  def follow
    authenticate_user!
    if params[:id] != current_user.id then
      @user = User.find(params[:id])
      @guest = true
      current_user.follow(@user)
      redirect_to(:controller => 'user', :action => 'guest_profile')
    else
      @follow_notice="some proper error msg"
      redirect_to(:back)
    end
  end

  def unfollow
    authenticate_user!
    if params[:id] != current_user.id then
      @user = User.find(params[:id])
      @guest = true
      current_user.stop_following(@user)
      redirect_to(:controller => 'user', :action => 'guest_profile')
    else
      @follow_notice="some proper error msg"
      redirect_to(:back)
    end
  end

  def guest_profile
  	@user = User.find(params[:id])
    if !current_user.nil? then
      if params[:id] == current_user.id then
        redirect_to(:controller => 'user', :action => 'profile')
      else
        @guest = true
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
