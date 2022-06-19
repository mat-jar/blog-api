namespace :rabbitmq do
  desc "Connect consumer to producer"
  task :setup do
    require "bunny"
    connection = Bunny.new.tap(&:start)
    channel = connection.create_channel
    queue_stats = channel.queue("stats_panel", :durable => true)
    # bind queue to exchange
    queue_stats.bind("stats_update.new_article")
    connection.close
  end
end
