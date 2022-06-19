require 'bunny'

class Publisher
  class << self

    def publish(exchange, message = {})
      x = channel.fanout("stats_update.#{exchange}")
      x.publish(message.to_json)
      #y = channel.queue('hello')
      #y.publish('Hello World from Rails!', routing_key: y.name)
    end

    def channel
      @channel ||= connection.create_channel
    end
    def connection
      @connection ||= Bunny.new.tap(&:start)
    end
  end
end
