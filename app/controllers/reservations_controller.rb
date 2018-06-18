class ReservationsController < ApplicationController

	# before_action :set_listing, only: [:new, :create]

	def new
		@listing = Listing.find(params[:listing_id])
		@reservation = Reservation.new
	end

	def create	
		@reservation = current_user.reservations.create(reservation_params)
		# @reservation.end_date = params[end_date]
		Listing.find(params[:listing_id]).reservations << @reservation

		if @reservation.save
			redirect_to user_reservations_path(current_user) # 'reservations/show'
		else
			# redirect_to new_reservation_path
			redirect_to listings_path # render :new
		end
	end

	def index
		@reservations = Reservation.where(user_id: current_user.id)
	end

	def your_reservations
		@reservations = Reservation.where(user_id: current_user.id)
	end

	def listing_reservations
		@listing = Listing.find(params[:listing_id])
		@reservations = Reservation.where(listing_id: params[:listing_id])
		render "listings/listing_reservations"
	end

	def show
	end

	private
		def reservation_params
			params.require(:reservation).permit(:start_date, :end_date, :guest_number)
		end

		# def set_listing
		# 	@listing = Listing.find(params[:listing_id])
		# end

end