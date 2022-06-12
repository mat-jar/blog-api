class FlashcardSetSettingsPanel < ApplicationRecord
  belongs_to :user
  belongs_to :flashcard_set
  belongs_to :flashcard_resume_flashcards, class_name: 'FlashcardSetSettingsPanel',
                            foreign_key: 'flashcard_resume_id'
end
