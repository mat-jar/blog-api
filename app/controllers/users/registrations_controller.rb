class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :configure_permitted_parameters
  before_action :check_teacher_token, only: [:create, :update]
  before_action :authenticate_user!, only: :check_teacher_id

  private

  def sign_up(resource_name, resource)
  end

  def respond_with(resource, _opts = {})

    resource.persisted? ? register_success : register_failed
  end

  def register_success
    render json: { message: "Signed up."}, status: :ok
  end

  def register_failed
    render json: { message: "Signed up failure." },  status: :unprocessable_entity

  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :teacher_token, :teacher_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role, :teacher_token, :teacher_id])
  end

  def check_teacher_id
    if request.headers['Authorization'].present?
      authorize_with_token
    else
      render json: { message: "Authorization token is needed"}, status: :unauthorized
      return
    end

    user = request.env['warden'].user
    if (user && user.admin?)
      return
    elsif (user && user.teacher?)
      if !(params[:user][:teacher_id].to_i == user.id)
        render json: { message: "Teacher can only add their own student"}, status: :forbidden
      end
    else
      render json: { message: "Only teacher or admin can add a student to a teacher"}, status: :forbidden
    end

  end

  def authorize_with_token
    token = request.headers.fetch('Authorization', '').split(' ').last
    payload = Warden::JWTAuth::TokenDecoder.new.call(token)
    user = User.find(payload['sub'])
    if user
      request.env['warden'].set_user(user)
    else
        render json: { message: "Authorization token is invalid"}, status: :unauthorized
    end
  end


  def check_teacher_token
    if (params[:user] && params[:user][:teacher_id])
      check_teacher_id
    end

    if (params[:user] && params[:user][:teacher_token])
      teacher_token = TeacherToken.where(token: params[:user][:teacher_token])[0]
      if teacher_token
        params[:user][:teacher_id] = TeacherToken.where(token: params[:user][:teacher_token])[0].teacher.id
        teacher_token.destroy
        params[:user].delete(:teacher_token)
      else
        render json: { message: "Signed up failure - wrong teacher token"}, status: :unprocessable_entity
      end
    end
  end

end
