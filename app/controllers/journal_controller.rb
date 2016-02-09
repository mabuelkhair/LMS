class JournalController < ApplicationController
  before_action :authenticate_user!
  def browse

  		@have_interest = true
  		if current_user.interests.empty? then
  			@have_interest=false
  			con = JournalHelper::GuardianConnection.new(resource: "search")
  			@articles=con.get({ :q => "" })["results"]
  		else
  			querystr = ""
  			current_user.interests.each do |interest|
  				querystr.concat(interest.name).concat("%20OR%20")
  			end
  			puts querystr
  			con = JournalHelper::GuardianConnection.new(resource: "search")
  			@articles=con.get({ :q => querystr })["results"]
  		end
  end
  def set_interests
  	interests = params[:interests].scan(/#(\w+)/).flatten
  	interests.each do |interest|
  		if Interest.exists?(:name => interest) then
  			current_user.interests.append(Interest.where(:name => interest).first)
  		else
  			current_user.interests.create(name: interest)
  		end
  	end
  end

end