class ListingsController < ApplicationController
	before_action :require_host_admin, only: [:create, :new, :update, :edit]
	before_action :require_host_moderator_admin, only: [:destroy]
	before_action :require_moderator_admin, only: [:verify]
	before_action :require_customer, only: [:reserve]
	
	def new
		@listing = Listing.find(params[:id])
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
	end

	def update		
		@listing = Listing.find(params[:id])
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

	private
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
        redirect_to listing_path(params[:id]), notice: "Sorry. You do not have the permissino to verify a property."
		end
	end

	def require_customer
		unless current_user.customer?
			flash[:notice] = "Sorry. You are not allowed to perform this action."
        redirect_to 'listing_path(params[:id])', notice: "Sorry. You do not have the permissino to verify a property."
		end
	end
end





