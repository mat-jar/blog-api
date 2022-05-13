class LearningSession < ApplicationRecord
  belongs_to :user
  belongs_to :flashcard_set
  has_many :answer_times
  validates :flashcard_set, :user, presence: true
end
