class Users::SessionsController < Devise::SessionsController
  include Devise::Controllers::Helpers
  respond_to :json
  skip_before_action :verify_signed_out_user #without I couldn't override destroy since I'm not ussing sessions and Devise thinks nobody's logged

  def sign_in(resource_name, resource)
    super
    current_user.update(logged_in: true)
  end

  def destroy
    if !current_user
      log_out_failure
      return
    else
      current_user.update(logged_in: false)
    end

    super

  end


private

  def respond_with(resource, _opts = {})

    response.set_header('Hej', 'Mati')
    render json: {message: 'Logged.'}, status: :ok
    #render json: current_user, status: :ok
  end

  def respond_to_on_destroy

    !current_user ? log_out_success : log_out_failure
  end

  def log_out_success
    render json: { message: "Logged out." }, status: :ok
  end

  def log_out_failure
    render json: { message: "Logged out failure."}, status: :unauthorized
  end
end
