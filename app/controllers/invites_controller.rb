class InvitesController < ApplicationController
  def generate_token
    group = Group.find(params[:group_id])
    invite_token = Devise.friendly_token
    group.update(invite_token: invite_token )

    InviteTokenRemovalJob.set(wait: 30.minutes).perform_later(group.id)

    redirect_to group_path(group), notice: "#{group.name}の招待リンクを作成しました。リンクをコピーして招待したい人にURLを送りましょう!"
  end

  def process_invite_link
    @group = Group.find_by(invite_token: params[:invite_token])
    session[:group_id] = @group.id

    if user_signed_in? && !GroupUser.find_by(group_id: @group.id, user_id: current_user.id).present?
      @group.users << current_user
      session[:group_id] = nil
      @group.update(invite_token: nil)

      redirect_to root_path, notice: "#{@group.name}グループに追加されました"
    else
      redirect_to user_session_path
    end
  end
end
