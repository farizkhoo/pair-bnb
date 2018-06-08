class UsersController < Clearance::UsersController
	before_action :require_login 

	def index
	end
end
