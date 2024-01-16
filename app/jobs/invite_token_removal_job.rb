class InviteTokenRemovalJob < ApplicationJob
  queue_as :default

  def perform(group_id)
    group = Group.find_by(id: group_id)
    group.update(invite_token: nil) if group.invite_token.present?
  end
end
