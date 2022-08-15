class Flashcard < ApplicationRecord
  belongs_to :flashcard_set
  has_many :flashcard_set_settings_panels
  has_many :answer_times
  validates :front_text, :back_text, presence: true
  has_one_attached :front_photo
  has_one_attached :back_photo
  validate :acceptable_flashcard_photo

  def acceptable_flashcard_photo
    return unless front_photo.attached?
    return unless back_photo.attached?

    unless front_photo.byte_size <= 300.kilobyte
      errors.add(:front_photo, "is too big")
    end
    unless back_photo.byte_size <= 300.kilobyte
      errors.add(:back_photo, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png"]

    unless acceptable_types.include?(front_photo.content_type)
      errors.add(:front_photo, "must be a JPEG or PNG")
    end
    unless acceptable_types.include?(back_photo.content_type)
      errors.add(:back_photo, "must be a JPEG or PNG")
    end

  end
end
