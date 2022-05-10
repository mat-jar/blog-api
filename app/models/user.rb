class User < ApplicationRecord
  enum role: { student: 0, teacher: 1, admin: 2 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  has_many :flashcard_sets
  has_many :flashcards, through: :flashcard_sets
  has_many :flashcard_set_settings_panels, dependent: :destroy
  has_many :learning_sessions

end
