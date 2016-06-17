class HomeController < ApplicationController
  def index
  	if current_user
    	render :feed
	end
  end

  def about
  end

  def us
  end
  def contact
  end
  
end
