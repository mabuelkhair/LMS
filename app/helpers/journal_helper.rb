module JournalHelper
	class GuardianConnection
		attr_accessor :url, :resource

		def initialize(params = {})
			@resource = params[:resource]
			@url = params[:url] || "http://content.guardianapis.com"
		end

		def get(params = {})
			addressable = Addressable::URI.new
			addressable.query_values = params.merge({ format: "json",:'api-key' => "e2c6bc96-97b0-407a-9a26-0c83e2b0d2c8",:'order-by' => "newest",:'page-size' => 50 })
			result = "#{@url}/#{resource}?#{addressable.query}" 
			puts "#{result}"
			self.parse(HTTParty.get(result))
		end

		def parse(response)
			result=JSON.parse(response.body)
			puts "#{result}"
			result["response"]
		end
	end
end
