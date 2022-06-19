class Article < ApplicationRecord
  validates :title, :body, presence: true
  after_create { publish_to_stats_panel }

  private
  def publish_to_stats_panel
    Publisher.publish('new_article', attributes)
  end
end
