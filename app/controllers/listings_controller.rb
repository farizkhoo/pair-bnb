class ListingsController < ApplicationController
	# def user_specific

	# 	# @user = User.find(params[:id])
	# 	# @listings = @user.listings
	# 	# render "index"
	# end

	def index
		@listing_count = Listing.count 
		@listings = Listing.page(1).per(10)
	end

	def show
		@listing = Listing.find(params[:id])
	end
end
