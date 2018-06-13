class UsersController < Clearance::UsersController
	before_action :require_login 

	def index
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		@user.update(update_users_params)
		@user.update(gender: params[:user][:gender] == "male" ? 0 : 1)
		@user.update(password: params[:user][:password]) if params[:user][:password].length != 0
		# uploader.retrieve_from_store!('my_file.png')

		redirect_to edit_user_path
	end

	private
	def update_users_params
		params.require(:user).permit(:first_name, :last_name, :email, :phone, :country, :birthdate, :avatar)
	end
end

