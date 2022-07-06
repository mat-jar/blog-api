class AnswerTime < ApplicationRecord
  belongs_to :learning_session
  belongs_to :flashcard
  validates :flashcard, :learning_session, :round, :time_millisecond,  presence: true
  validates :flashcard, uniqueness: { scope: [:round, :learning_session], message: "Can't have two answer times for the same flashcard in the same round of learning_session" }
  validate :does_flashcard_belong_to_learning_session

  def does_flashcard_belong_to_learning_session
    if  Flashcard.find(flashcard_id).flashcard_set != LearningSession.find(learning_session_id).flashcard_set
      errors.add(:answer_time, "Flashcard and learning session can't have different flashcard sets")
    end
  end
end
