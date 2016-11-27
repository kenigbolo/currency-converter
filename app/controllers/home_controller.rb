# rubocop:disable FrozenStringLiteralComment
# ! Calculation controller methods
class HomeController < ApplicationController
  def index
  end

  def logout
    sign_out
    reset_session
    redirect_to root_path
  end
end
