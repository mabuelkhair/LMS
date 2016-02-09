class JournalController < ApplicationController
  def browse
  		con = JournalHelper::GuardianConnection.new(resource: "search")
  		@articles=con.get({ :q => "obama" })["results"]

  end
end