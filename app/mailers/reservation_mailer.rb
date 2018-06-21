class ReservationMailer < ApplicationMailer
	def reservation_email(customer, host, reservation)
		@customer = customer
		@host = host
		@reservation = reservation
		@url = user_listing_reservation_url(id: @reservation.id, listing_id: @reservation.listing_id, user_id: @host.id)
		mail(to: @host.email, subject: 'New Reservation from FrizzBNB')
	end

	def customer_reservation(customer, host, reservation)
		@customer = customer
		@host = host
		@reservation = reservation
		@listing = Listing.find(@reservation.listing_id)
		@url = your_reservations_url
		@listing_url = listing_url(@listing.id)
		mail(to: @customer.email, subject: "FrizzBNB - Reservation at #{@listing}")
	end

end
