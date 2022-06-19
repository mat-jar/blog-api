class MessageStorage
  KEY = "message_storage"
  STORE_LIMIT = 100
  def self.list(limit = STORE_LIMIT)
    $redis.lrange(KEY, 0, limit).map do |raw_messages|
      JSON.parse(raw_messages)
    end
  end

  def self.push(raw_messages)
    messages = JSON.parse(raw_messages)
    broadcast_messages(messages)
    $redis.lpush(KEY, raw_messages)
    $redis.ltrim(KEY, 0, STORE_LIMIT-1)
  end

  private
  def self.broadcast_messages(messages)
    ActionCable.server.broadcast 'messages',
      name: messages['name'],
      city: messages['city']
  end
  
end
