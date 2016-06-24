class HomeController < ApplicationController
  
  def index
  	if current_user
      @posts= Post.where("user_id IN(?) OR user_id = ?",Follow.select(:followable_id).where(:follower_id => 11), User.first.id).order("created_at DESC")
      render :feed
	  end
  end

  def add_post
    authenticate_user!
    post= Post.new(:content => params[:status])
    current_user.post << post
    redirect_to(:controller => 'home' ,:action => 'index')
  end

   def delete_post
    authenticate_user!
    post= current_user.post.find(params[:id])
    rescue ActiveRecord::RecordNotFound  
     redirect_to :controller => "home", :action => "index"
    return
    post.destroy
    redirect_to(:controller => 'home' ,:action => 'index')
  end

  def about
  end

  def us
  end
  def contact
  end
  
end