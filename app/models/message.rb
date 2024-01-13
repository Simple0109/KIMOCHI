class Message < ApplicationRecord
  belongs_to :request
  belongs_to :user

  def formatted_created_at
    created_at.strftime("%m/%d %H:%M")
  end
end
