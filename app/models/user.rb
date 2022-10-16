class User < ApplicationRecord
  enum role: { student: 1, teacher: 2, admin: 3 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
  has_many :flashcard_sets, dependent: :destroy
  has_many :flashcards, through: :flashcard_sets
  has_many :flashcard_set_settings_panels, dependent: :destroy
  has_many :learning_sessions
  has_many :answer_times, through: :learning_sessions
  has_many :students, class_name: "User", foreign_key: "teacher_id"
  has_many :teacher_tokens
  belongs_to :teacher, class_name: "User", optional: true
  validate :is_teacher_and_student

  def is_teacher_and_student

    if  teacher_id.present? && (User.find(teacher_id).role != "teacher" || role != "student")
      errors.add(:teacher_id, "teacher must be a teacher and student a student")
    end

  end

  def jwt_payload
    { "last_login_at" => Time.now.to_i}
  end

  def on_jwt_dispatch(token, payload)
    User.find(payload["sub"]).update(last_login_at: payload["last_login_at"])
  end

end
