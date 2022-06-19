$redis = Redis::Namespace.new("flashcards-api:#{Rails.env}", redis: Redis.new)
