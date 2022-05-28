class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    #render json: { message: resource.to_s }
    #render json: { message: resource.persisted?.to_s }
    resource.persisted? ? register_success : register_failed
  end

  def register_success
    render json: { message: "Signed up." }, status: :ok
  end

  def register_failed
    render json: { message: "Signed up failure." },  status: :unprocessable_entity

  end
end
