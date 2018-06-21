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
		@listing = Listing.find(params[:listing_id])
		@host = User.find(@listing.user_id)
		@reservation = current_user.reservations.new(reservation_params)
		@reservation.listing_id = params[:listing_id]

		if @reservation.save
			ReservationMailer.reservation_email(current_user, @host, @reservation).deliver_now
			ReservationMailer.customer_reservation(current_user, @host, @reservation).deliver_now

			redirect_to your_reservations_path, :flash => {:success => "Reservation successful!"} # 'reservations/show'
		else
			# redirect_to new_reservation_path
			redirect_to listing_path(params[:listing_id]), :flash => {:error => "Reservation failed!"} # render :new
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
		@reservation = Reservation.find(params[:id])
		@listing = Listing.find(params[:listing_id])
		@customer = User.find(@reservation.user_id)
	end

	private
		def reservation_params
			params.require(:reservation).permit(:start_date, :end_date, :guest_number)
		end

		# def set_listing
		# 	@listing = Listing.find(params[:listing_id])
		# end

end