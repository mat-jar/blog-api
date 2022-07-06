class Users::UserDetailsController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: current_user
  end

  def show_accessible
    users = User.all
    render json: users
  end

  def update
    if user_id.empty?
      current_user.update(user_param)
      render json: current_user
    else
      id = user_id['user_id']
      user = User.find(id)

      if user.update(user_param)
        render json: user
      else
        render json: user.errors
      end
    end
  end

  private
    def user_param
      params.require(:user).permit(:name, :teacher_id, :role)
    end
    def user_id
      params.require(:user).permit(:user_id)
    end
end
