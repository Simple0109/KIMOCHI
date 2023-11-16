class Profile < ApplicationRecord
  belongs_to :user
  validates :name, presence :true, length: { maximum: 20 }
  validates :role, presence :true

  enum role: { general: 0, admin: 1 }
end
