class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :destroy]


  def index
    @group = Group.all
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
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @group.update(group_params)
    redirect_to root_path
  end

  def destroy
    @group.destroy
    redirect_to root_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end

  def set_group
    @group = Group.find(params[:id])
  end

end
