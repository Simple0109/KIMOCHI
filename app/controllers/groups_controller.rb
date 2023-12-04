class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]


  def index
    @user_groups = current_user.groups.order(created_at: :desc)
  end

  def new
    @group = Group.new
  end

  def show
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

  def edit;end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
       render :edit
    end

  end

  def destroy
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
