class Request < ApplicationRecord
  validates :take, :status, presence: true
  validates :image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }

  enum status: { draft: 0, unauthorized: 1, authorized: 2, possible: 3 }

  has_one_attached :image

  belongs_to :user
  belongs_to :group
  has_many :request_users, dependent: :destroy
  has_many :authorizers, through: :request_users, source: :user
  has_many :gives, class_name: "Give", dependent: :destroy
  accepts_nested_attributes_for :gives, allow_destroy: true, reject_if: :all_blank, limit: 3

  def image_thumbnail
    if image.attached?
      image.variant(resize_to_fit: [720, 600]).processed
    end
  end


  def authorizers_check(current_user)
    self.authorizers.where(id: current_user.id).exists?
  end

  def own?(current_user)
    self.user_id == current_user.id
  end

end
