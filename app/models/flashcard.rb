class Flashcard < ApplicationRecord
  belongs_to :flashcard_set
  has_many :flashcard_set_settings_panels
end
