class Group < ApplicationRecord
  before_create :generate_invite_password

  validates :name, presence: true
  validates :invite_password, uniqueness: true

  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users

  has_many :requests, dependent: :destroy

  private

  def generate_invite_password
    self.invite_password = SecureRandom.base64(20)
  end
end
