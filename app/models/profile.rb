class Profile < ApplicationRecord
  before_create :set_default_avatar

  belongs_to :user

  has_one_attached :avatar

  validates :name, presence: true, length: { maximum: 20 }
  validates :role, presence: true
  validates :avatar, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }

  def avatar_thumbnail
    avatar.variant(resize_to_limit: [1200, 400]).processed
  end

  private

  def set_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(Rails.root.join("public", "default_avatar.png")),
        filename: "default_avatar.png",
        content_type: "image/png"
      )
    end
  end

end
