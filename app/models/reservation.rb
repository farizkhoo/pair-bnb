class Reservation < ApplicationRecord
  	belongs_to :user
  	belongs_to :listing
    # before_create :check_date_availability
    validates_presence_of :start_date, :end_date
    # validates :check_in, presence: true
    # validates :check_out, presence: true
    validate :check_overlapping_dates, if: :check_error
    
    def check_error
        self.errors.blank?
    end 
    
    def check_overlapping_dates
    	dates = []
    	listing.reservations.each do |x|
    		dates += (x.start_date.to_date...x.end_date.to_date).to_a
    	end
    	if (dates & (self.start_date.to_date...self.end_date.to_date).to_a).count != 0
			errors.add(:overlapping_dates, "the reservation dates conflict")
   		end
    end

    # def check_overlapping_dates
    #     listing.reservations.each do |old_booking|
    #         if overlap?(self, old_booking)
    #             if self == old_booking
    #                 return true
    #             else
    #                 errors.add(:overlapping_dates, "the reservation dates conflict")
    #             end
    #         end
    #     end
    # end
    
    # def overlap?(x,y)
    #     if y.start_date != nil and y.end_date != nil
    #         (x.start_date - y.end_date).to_i * (y.start_date - x.end_date).to_i > 0
    #     end
    # end
end
