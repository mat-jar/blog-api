class StatsPanelWorker
  include Sneakers::Worker

  from_queue "stats_panel"
  def work(raw_stats)
    StatsPanel.push(raw_stats)
    ack!
  end
end
