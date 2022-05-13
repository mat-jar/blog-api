class AnswerTime < ApplicationRecord
  belongs_to :learning_session
  belongs_to :flashcard
end
