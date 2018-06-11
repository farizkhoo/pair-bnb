class ApplicationController < ActionController::Base
  include Clearance::Controller

  # def allowed?(action:, user:)
  #   # implement some code
  #   if !user.admin?
  #   	redirect_to root_path if "listings#new"
  #   end
  # end
end
