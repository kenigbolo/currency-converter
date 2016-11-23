class HomeController < ApplicationController
	def index
		@calculation = Calculation.new
	end
end
