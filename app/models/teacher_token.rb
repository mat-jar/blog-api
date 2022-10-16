class TeacherToken < ApplicationRecord
  belongs_to :teacher, class_name: "User"
  has_secure_token length: 6

  validate :is_user_a_teacher


  def is_user_a_teacher
    if  User.find(teacher_id).role != "teacher"
      errors.add(:teacher_id, "user must be a teacher to add a teacher token")
    end
  end

end
