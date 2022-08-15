class FreshTokenStrategy < Warden::Strategies::Base
  def valid?
    api_token.present?
  end

  def authenticate!
    user = Warden::JWTAuth::UserDecoder.new.call(api_token, :user, nil)
    last_login_at_from_user = user.last_login_at
    last_login_at_from_token = Warden::JWTAuth::TokenDecoder.new.call(api_token)["last_login_at"]

    if !(last_login_at_from_user == last_login_at_from_token)
      fail!('Outdated token')
    end
  end

  private

  def api_token
    env['HTTP_AUTHORIZATION'].to_s.remove('Bearer ')
  end
end
