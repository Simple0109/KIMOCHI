class Request < ApplicationRecord
  validates :take, :status, :give1, presence: true
  validates :image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }

  enum status: { drift: 0, not_authorized: 1, authorized: 2, approved: 3 }

  has_one_attached :image

  belongs_to :user
  belongs_to :group
  has_many :request_users, dependent: :destroy
  has_many :authorizers, through: :request_users, source: :user

  def image_thumbnail
    if image.attached?
      image.variant(resize_to_fit: [720, 600]).processed
    end
  end

end
