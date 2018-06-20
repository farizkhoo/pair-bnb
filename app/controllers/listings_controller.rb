class ListingsController < ApplicationController
	before_action :require_host_admin, only: [:update, :edit]
	before_action :require_host_moderator_admin, only: [:destroy]
	before_action :require_moderator_admin, only: [:verify]
	before_action :require_customer, only: [:reserve]
	before_action :require_host, only: [:new, :create]
	
	def create
		@new = current_user.listings.new(listing_params)
		if @new.save
			redirect_to '/listings/tobeverified'
		end
    end 

    def tobeverified
    end

    def new
    	@user = current_user
    	@listing = Listing.new
    end

	def index
		@listing_count = Listing.where(verified: true).count
		@listings = Listing.page(params[:page]).per(10).where(verified: true)
	end

	def show
		@listing = Listing.find(params[:id])
	end

	def edit
		@listing = Listing.find(params[:id])
		@user = User.find(params[:user_id])
	end

	def update		

		@listing = Listing.find(params[:id])
		@listing.update(listing_params)

		flash[:notice] = "Listing successfully updated"

		redirect_to edit_user_listing_path
	end

	def destroy
		@listing = Listing.find(params[:id])
	end

	def verify
		@listing = Listing.find(params[:id])
		@listing.update(verified: true)
		redirect_to listing_path(@listing)
	end

	def unverified
		@listing_count = Listing.where(verified: false).count
		@listings = Listing.page(params[:page]).per(10).where(verified: false)
	end

	def reserve
		@listing = Listing.find(params[:id])
	end

	def your_listings
		@listings = Listing.where(user_id: current_user.id)
		render "listings/your_listings"
	end

	private
	def listing_params
		params.require(:listing).permit(:location, :tags, :name, :place_type, :property_type, :room_number, :bed_number, :guest_number, :country, :state, :city, :zipcode, :price, :description, :listing_cover, {:image => []})
	end

	def require_host_admin
		unless current_user == Listing.find(params[:id]).user || current_user.admin?
			flash[:notice] = "Sorry. You are not allowed to perform this action."
        redirect_to 'listing_path(params[:id])', notice: "Sorry. You do not have the permissino to verify a property."
		end
	end

	def require_host_moderator_admin
		unless current_user == Listing.find(params[:id]).user || current_user.moderator? || current_user.admin?
			flash[:notice] = "Sorry. You are not allowed to perform this action."
        redirect_to 'listing_path(params[:id])', notice: "Sorry. You do not have the permissino to verify a property."
		end
	end

	def require_moderator_admin
		unless current_user.moderator? || current_user.admin?
			flash[:notice] = "Sorry. You are not allowed to perform this action."
        redirect_to 'listing_path(params[:id])', notice: "Sorry. You do not have the permissino to verify a property."
		end
	end

	def require_customer
		unless current_user.customer?
			flash[:notice] = "Sorry. You are not allowed to perform this action."
        redirect_to 'listing_path(params[:id])', notice: "Sorry. You do not have the permissino to verify a property."
		end
	end

	def require_host
		unless current_user == User.find(params[:user_id]) || current_user.admin?
			flash[:notice] = "Sorry. You are not allowed to perform this action."
        redirect_to 'listing_path(params[:id])', notice: "Sorry. You do not have the permissino to verify a property."
		end
	end	
end





