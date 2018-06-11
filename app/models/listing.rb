class Listing < ApplicationRecord
	belongs_to :user

	def display_infos
		string = ""
		self.attributes.keys.each do |k|
			string += "<div id='#{k}'> #{k} : #{self[k]}</div>"
		end
		return string
	end
	
end
