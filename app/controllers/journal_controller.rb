class JournalController < ApplicationController
  def browse
  		Custodian.api_key="e2c6bc96-97b0-407a-9a26-0c83e2b0d2c8"
  		@articles = Custodian::Article.find(:all, {:q => "Obama"})
  end
end
