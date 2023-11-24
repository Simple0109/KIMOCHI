class InvitesController < ApplicationController


  def new;end

  def create
    group = Group.find_by(invite_password: params[:invite_password])

    if group.present?
      group.users << current_user
      redirect_to root_path
    else
      render :edit
    end
  end

end
