class User < ApplicationRecord
	include Clearance::User
	def index
	end
end