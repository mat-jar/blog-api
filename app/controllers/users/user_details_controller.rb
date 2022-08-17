class Users::UserDetailsController < ApplicationController
  before_action :authenticate_user!

  def show
    if user_id.empty?
      render json: current_user, status: :ok
    else
      id = user_id['user_id']
      user = User.find(id)
      authorize! :show, user
      render json: user, status: :ok
    end
  end

  def show_all
    if current_user.admin?
      users = User.all
      render json: users, status: :ok
    else
      render status: :forbidden
    end
  end

  def update

    if user_id.empty?
      if current_user.update(user_param)
        render json: current_user, status: :ok
      else
        render json: current_user.errors,  status: :unprocessable_entity
      end
    else
      id = user_id['user_id']
      user = User.find(id)
      authorize! :update, user

      if user.update(user_param)
        render json: user, status: :ok
      else
        render json: user.errors,  status: :unprocessable_entity
      end
    end
  end

  private
    def user_param
      params.require(:user).permit(:name, :teacher_id, :role, :profile_photo)
    end
    def user_id
      params.fetch(:user, {}).permit(:user_id)
    end
end
