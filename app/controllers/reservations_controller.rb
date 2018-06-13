class ReservationsController < ApplicationController

	# before_action :set_listing, only: [:new, :create]

	def new
		@listing = Listing.find(params[:listing_id])
		@reservation = Reservation.new
	end

	def create
		@reservation = current_user.reservation.create(reservation_params)
		@reservation.listing_id = params[:listing_id]
		@reservation.user_id = params[:user_id]

		if @reservation.save
			redirect_to user_reservations_path(current_user) # 'reservations/show'
		else
			# redirect_to new_reservation_path
			redirect_to listings_path # render :new
		end
	end

	def index
		@reservations = Reservation.find_by(user_id: current_user.id)
		@listing = @reservations.listing_id
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