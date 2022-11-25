class UserSentence < ApplicationRecord
  belongs_to :user_sentence_set
  validates :sentence, presence: true
end
