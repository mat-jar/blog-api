class FlashcardSet < ApplicationRecord
  belongs_to :user
  has_many :flashcards, dependent: :destroy
  has_many :flashcard_set_settings_panels, dependent: :destroy
  accepts_nested_attributes_for :flashcards
  validates :title, presence: true
  has_many :learning_sessions
  has_many :answer_times, through: :learning_sessions
end
