class GroupsController < ApplicationController
  before_action :authenticate_user!, only: %i[index new show create edit destroy update]
  before_action :set_group, only: %i[show edit update destroy]

  def index
    @user_groups = current_user.groups.order(updated_at: :desc).page(params[:page])
  end

  def new
    @group = Group.new
  end

  def show
    return unless @group.invite_token.present?

    @invite_link = group_invite_link_url(@group, invite_token: @group.invite_token)
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      @group.users << current_user
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end
  end

  def destroy
    return unless @group.group_users.exists?(user_id: current_user.id)

    @group.destroy
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :invite_token)
  end

  def set_group
    @group = Group.includes(:users).find(params[:id])
  end
end
