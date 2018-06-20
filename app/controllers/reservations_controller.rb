class ReservationsController < ApplicationController

	# before_action :set_listing, only: [:new, :create]

	def new
		@listing = Listing.find(params[:listing_id])
		@dates = []
		@reservations = @listing.reservations
		@reservations.each do |r|
			@dates += (r.start_date.to_date...r.end_date.to_date).to_a
			@dates.map!{|z| z.to_s}
		end
		@reservation = Reservation.new
	end

	def create	
		@reservation = current_user.reservations.new(reservation_params)
		# @reservation.end_date = params[end_date]
		@reservation.listing_id = params[:listing_id]

		if @reservation.save
			flash[:success] = "Reservation successful!"

			redirect_to your_reservations_path # 'reservations/show'
		else
			# redirect_to new_reservation_path
			flash[:error] = "Failed to reserve"

			redirect_to listing_path(params[:listing_id]) # render :new
		end
	end

	def index
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