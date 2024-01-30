class Group < ApplicationRecord
  validates :name, presence: true

  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users

  has_many :requests, dependent: :destroy

  belongs_to :owner, class_name: 'User', foreign_key: 'user_id', inverse_of: :owned_groups

  def owner?(user)
    user_id == user.id
  end
end
