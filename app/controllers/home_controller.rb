class HomeController < ApplicationController
	def index
	end

	def edit
    @calculation = current_user.calculations.find(params[:id])
    unless current_user == @calculation.user
      redirect_back(fallback_location: root_path)
    end
  end

	def logout
		sign_out
		reset_session
		redirect_to root_path
	end
end
