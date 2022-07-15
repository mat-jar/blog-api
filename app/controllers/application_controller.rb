class ApplicationController < ActionController::API

  rescue_from CanCan::AccessDenied do |exception|
   if current_user
     render status: :forbidden # 403
   #else
   # render status: :unauthorized # 401 unauthenticated
   end
 end

 rescue_from ActiveRecord::RecordNotFound do |_exception|
    render status: :not_found #404
  end

 end
