class AdminController < ApplicationController
	before_action :require_admin, only: [:index]

	def index
	end

	private
	def require_admin
		unless current_user.admin?
			flash[:notice] = "Sorry. You are not allowed to perform this action."
        	redirect_to root_path, notice: "Sorry. You do not have the permission to view this page."
		end
	end
end
