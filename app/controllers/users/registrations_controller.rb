class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :configure_permitted_parameters

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
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :role, :teacher_id) }
  end

end
