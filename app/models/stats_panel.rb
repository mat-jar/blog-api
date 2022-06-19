class StatsPanel < ApplicationRecord

    def self.push(raw_stats)
      sp = StatsPanel.new(message: raw_stats)
      sp.save!
    end
end


=begin
class StatsPanel < ApplicationRecord
  KEY = "stats_panel"
  STORE_LIMIT = 10
  def self.list(limit = STORE_LIMIT)
    $redis.lrange(KEY, 0, limit).map do |raw_stats|
      JSON.parse(raw_stats)
    end
  end
  def self.push(raw_stats)
    $redis.lpush(KEY, raw_stats)
    $redis.ltrim(KEY, 0, STORE_LIMIT-1)
  end
end
=end

=begin

class StatsPanel < ApplicationRecord

    def self.push(raw_stats)
      sp = StatsPanel.new(message: raw_stats)
      sp.save!
    end
end

=end
