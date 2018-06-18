class UsersController < Clearance::UsersController

	def index
	end

	def edit
		@user = current_user
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(users_params)
		@user.gender = params[:user][:gender] == "male" ? 0 : 1
		@user.password = params[:user][:password]

		if @user.save
			redirect_to root_path
		else
			render "new"
		end
	end

	def update
		@user = current_user
		@user.update(users_params)
		@user.update(gender: params[:user][:gender] == "male" ? 0 : 1)
		@user.update(password: params[:user][:password]) if params[:user][:password].length != 0
		# uploader.retrieve_from_store!('my_file.png')

		redirect_to edit_user_path
	end

	private
	def users_params
		params.require(:user).permit(:first_name, :last_name, :email, :phone, :country, :birthdate, :avatar)
	end
end

