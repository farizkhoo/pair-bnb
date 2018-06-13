class ReservationsController < ApplicationController

	before_action :set_listing, only: [:new, :create]

	def new
		@reservation = Reservation.new
	end

	def create
		@reservation = current_user.reservation.create(reservation_params)

		if @reservation.save
			redirect_to user_reservation_path(@reservation) # 'reservations/show'
		else
			# redirect_to new_reservation_path
			render :new
		end
	end

	def show
	end

	private
		def reservation_params
			params.require(:reservation).permit(:start_date, :end_date, :guest_number, :listing_id)
		end

		def set_listing
			@listing = Listing.find(params[:listing_id])
		end

end