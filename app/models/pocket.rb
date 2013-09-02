class Pocket < User
	def archive
		list = JSON.parse(retrieve)

		puts "-----------------"
		to_archive = []
		list["list"].each do |item_id, item|
			puts item_id
			puts "========="
			puts item
			puts "==="
		end
		puts "-----------------"
	end

	def retrieve
		url = 'get/'
		token = self.token
		consumer_key = ENV['POCKET_KEY']

		options = {
			:access_token => token,
			:consumer_key => consumer_key, 
			:since => (since.to_i if defined? since)
		}
		pocket_url = url_join(url_base, url)

		self.update 
		hello = RestClient.post pocket_url, options
	end

	def url_base
		version = "3" # If Pocket comes out with a new API version, this will come in handy.
		base_url = "https://getpocket.com/v#{version}/"
	end
end