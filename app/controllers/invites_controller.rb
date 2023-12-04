class InvitesController < ApplicationController

  #get
  def new
    @group =Group.new
    @group = Group.find(params[:group_id])

    if @group.invite_token.present?
      @invite_link = group_invite_link_url(invite_token: @group.invite_token)
    else
      @invite_link = ""
    end
  end

  #post
  def generate_token
    group = Group.find(params[:group_id])
    invite_token = Devise.friendly_token
    group.update(invite_token: invite_token )
    redirect_to group_invite_new_path(group_id: group.id)
  end

  def process_invite_link
    @group = Group.find_by(invite_token: params[:invite_token])
    session[:group_id] = @group.id

    if user_signed_in? && !GroupUser.find_by(group_id: @group.id, user_id: current_user.id).present?
      @group.users << current_user
      session[:group_id] = nil
      @group.update(invite_token: nil)

      redirect_to root_path, notice: "#{@group.name}に追加されました"
    else
      redirect_to user_session_path
    end
  end

end
