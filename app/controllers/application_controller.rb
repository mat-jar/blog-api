class ApplicationController < ActionController::API

  rescue_from CanCan::AccessDenied do |exception|
   if current_user
     render json: { message: "Not authorized"}, status: :forbidden # 403
   #else
   # render status: :unauthorized # 401 unauthenticated
   end
 end

 rescue_from ActiveRecord::RecordNotFound do |_exception|
    render status: :not_found #404
  end

  rescue_from ArgumentError do |_exception|
     render status: :unprocessable_entity #422
   end

   rescue_from JWT::ExpiredSignature do |_exception|
       render status: :unauthorized # 401 unauthenticated
    end

 end
