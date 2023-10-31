class Request < ApplicationRecord
  validates :take, :status, presence: true
  enum status: { drift: 0, not_authorized: 1, authorized: 2, approved: 3 }
end
