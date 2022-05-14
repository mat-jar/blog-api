class UserDetailsController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: { message: "User details" }
  end

  def update
    user = User.find(params[:id])
    user.update(user_param)
    render json: user
  end

  private
    def user_param
      params.require(:user).permit(:name, :teacher_id, :role)
    end
end
