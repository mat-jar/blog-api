class FlashcardSetSettingsPanel < ApplicationRecord
  belongs_to :user
  belongs_to :flashcard_set
  belongs_to :resume_flashcard, class_name: 'Flashcard',
                            foreign_key: 'resume_flashcard_id', optional: true
  enum order: { created: 1, alphabetize: 2, random: 3 }
  enum mode: { first_mode: 1, second_mode: 2, third_mode: 3 }
  enum answer_type: { right_wrong: 1, text_input: 2, multiple_choice: 3 }

  [:front_first, :audio, :answer_ignore_case].each {|a| attribute a, default: true}
  [:answer_ignore_punctuation, :answer_ignore_spaces, :answer_ignore_parentheses].each {|a| attribute a, default: false}
  [:order, :mode, :answer_type].each {|a| attribute a, default: 1}

end
