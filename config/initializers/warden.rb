require 'fresh_token_strategy'

Warden::Strategies.add(:fresh_token, FreshTokenStrategy)

Warden::Manager.after_authentication do |user,auth,opts|
  user.last_request_at = Time.now.utc
  user.save
end
