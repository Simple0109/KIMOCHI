class Group < ApplicationRecord

  validates :name, presence: true
  validates :invite_token, uniqueness: true

  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users

  has_many :requests, dependent: :destroy

end
