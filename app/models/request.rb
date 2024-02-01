class Request < ApplicationRecord
  validates :take, :status, presence: true
  validates :image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }

  enum status: { unauthorized: 0, authorized: 1, possible: 2, completed: 3 }

  has_one_attached :image

  belongs_to :user
  belongs_to :group
  has_many :request_users, dependent: :destroy
  has_many :authorizers, through: :request_users, source: :user
  has_many :gives, class_name: 'Give', dependent: :destroy
  accepts_nested_attributes_for :gives, allow_destroy: true, reject_if: :all_blank, limit: 3
  has_many :messages, dependent: :destroy

  def image_thumbnail
    return unless image.attached?

    image.variant(resize_and_pad: [610, 610]).processed
  end

  def authorizers_check(current_user)
    authorizers.where(id: current_user.id).exists?
  end

  def own?(current_user)
    user_id == current_user.id
  end
end
