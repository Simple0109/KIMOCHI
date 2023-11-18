class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar

  validates :name, presence: true, length: { maximum: 20 }
  validates :role, presence: true
  validates :avatar, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }

  def avatar_thumbnail
    avatar.variant(resize_to_limit: [1200, 400]).processed
  end

end
