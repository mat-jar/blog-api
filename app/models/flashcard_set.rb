class FlashcardSet < ApplicationRecord
  enum access: { shared: 0, personal: 1, class: 2 }
  belongs_to :user
  has_many :flashcards, dependent: :destroy
  has_many :flashcard_set_settings_panels, dependent: :destroy
  accepts_nested_attributes_for :flashcards
  validates :title, presence: true
  has_many :learning_sessions
  has_many :answer_times, through: :learning_sessions
end
