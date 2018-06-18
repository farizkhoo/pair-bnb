class Listing < ApplicationRecord
	belongs_to :user
	mount_uploader :image, ImageUploader
	has_many :reservation

	def display_infos
		string = ""
		self.attributes.keys.each do |k|
			string += "<div id='#{k}'> #{k} : #{self[k]}</div>"
		end
		return string
	end


	
end
