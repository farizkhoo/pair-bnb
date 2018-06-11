class UsersController < Clearance::UsersController
	before_action :require_login 

	def index
	end

	def edit
		@user = current_user
	end

end
