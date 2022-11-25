class AnswerTime < ApplicationRecord
  belongs_to :learning_session
  belongs_to :flashcard
  validates :flashcard, :learning_session, :round, :time_millisecond,  presence: true
  validates :flashcard, uniqueness: { scope: [:round, :learning_session], message: "Can't have two answer times for the same flashcard in the same round of learning_session" }
  validate :does_flashcard_belong_to_learning_session
  validates :time_millisecond, numericality: { in: 0..10000, only_integer: true }

  def does_flashcard_belong_to_learning_session
    return if ([ flashcard_id, learning_session_id].any?(&:blank?))
    if  Flashcard.find(flashcard_id).flashcard_set != LearningSession.find(learning_session_id).learnable
      errors.add(:answer_time, "Flashcard and learning session can't have different flashcard sets")
    end
  end
end
