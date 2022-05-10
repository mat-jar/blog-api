class LearningSession < ApplicationRecord
  belongs_to :user
  belongs_to :flashcard_set
end
