class RequestUser < ApplicationRecord
  belongs_to :request
  belongs_to :user

  enum status: { unapproved: 0, approval: 1}
end
