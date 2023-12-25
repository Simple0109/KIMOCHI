class RequestUser < ApplicationRecord
  belongs_to :request
  belongs_to :user

  enum approval_status: { unauthorized: 0, authorized: 1 }
end
