class Flashcard < ApplicationRecord
  belongs_to :flashcard_set
  has_many :flashcard_set_settings_panels
  has_many :answer_times
  validates :front_text, :back_text, presence: true
end
