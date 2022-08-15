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
  belongs_to :teacher, class_name: "User", optional: true
  validate :is_teacher_and_student
  has_one_attached :profile_photo
  validate :acceptable_profile_photo

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

  def acceptable_profile_photo
    return unless profile_photo.attached?

    unless profile_photo.byte_size <= 300.kilobyte
      errors.add(:profile_photo, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(profile_photo.content_type)
      errors.add(:profile_photo, "must be a JPEG or PNG")
    end
  end

end
