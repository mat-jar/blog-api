class ApplicationController < ActionController::API
  rescue_from CanCan::AccessDenied do |exception|
   if current_user
     render status: :forbidden # 403
   else
     render status: :unauthorized # 401 unauthenticated
   end
 end
end
