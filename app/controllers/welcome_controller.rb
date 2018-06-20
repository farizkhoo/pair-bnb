class WelcomeController < ApplicationController
	def index
		@listings = Listing.where(verified: true).sample(4)
	end
end
