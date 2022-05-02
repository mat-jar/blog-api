class UserDetailsController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: { message: "User details" }
  end
end
