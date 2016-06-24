class HomeController < ApplicationController
  
  def index
  	if current_user
    	render :feed
	  end
  end

  def add_post
    post= Post.new(:content => params[:status])
    current_user.post << post
    render :feed
  end

  def about
  end

  def us
  end
  def contact
  end
  
end