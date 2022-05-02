Warden::JWTAuth::Middleware::TokenDispatcher.class_eval do
  ENV_KEY = 'warden-jwt_auth.token_dispatcher'
    def call(env)

      env[ENV_KEY] = true
          status, headers, response = app.call(env)
          headers = headers_with_token(env, headers)
          response.body.replace(response.body[0..-2].concat(",\"auth_token\":\"#{headers['Authorization']}\"}") )
          [status, headers, response]
    end
end
