class MessageStorageWorker
  include Sneakers::Worker

  from_queue "stats_panel"
  def work(raw_messages)
    MessageStorage.push(raw_messages)
    ack!
  end
end
