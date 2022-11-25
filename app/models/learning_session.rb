class LearningSession < ApplicationRecord
  belongs_to :user
  belongs_to :learnable, :polymorphic => true
  has_many :answer_times
  validates :learnable, :user, presence: true
end
