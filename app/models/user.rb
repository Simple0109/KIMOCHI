class User < ApplicationRecord
  validates :name, :role, presence: true

  enum role: { general: 0, admin: 1 }

  has_many :group_users
  has_many :groups, thorough: :group_users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
