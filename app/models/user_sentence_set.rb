class UserSentenceSet < ApplicationRecord
  enum access: { shared: 1, personal: 2, class: 3}
  belongs_to :user
  has_many :user_sentences, dependent: :destroy
  accepts_nested_attributes_for :user_sentences
  validates :title, presence: true
  has_many :learning_sessions, as: :learnable
  #has_many :answer_times, through: :learning_sessions

  def to_param
    return nil unless persisted?
    "#{id}-#{title.parameterize}" # 12-human-body
  end

end
