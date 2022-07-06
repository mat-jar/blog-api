class FlashcardSetSettingsPanel < ApplicationRecord
  belongs_to :user
  belongs_to :flashcard_set
  belongs_to :resume_flashcard, class_name: 'Flashcard',
                            foreign_key: 'resume_flashcard_id'
end
