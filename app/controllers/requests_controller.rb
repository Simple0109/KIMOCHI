class RequestsController < ApplicationController
  before_action :set_request, only: [:edit, :update, :destroy]

  def index
    @requests = Request.where(group_id: params[:group_id])
    @group = Group.find(params[:group_id])
  end

  def new
    @request = Request.new
    @group = Group.includes(users: :profile).find(params[:group_id])
  end

  def show
    @request = Request.includes(user: :profile).find(params[:id])
  end

  def create
    @request = Request.new(request_params)
    @authorizer_ids = params[:request][:authorizer_ids].map(&:to_i)
    @authorizer_ids.shift

    if @request.save
      @authorizer_ids.each do |authorizer_id|
        authorizer = User.find(authorizer_id)
        @request.authorizers << authorizer
      end
      redirect_to group_requests_path
    else
      render :new
    end
  end

  def edit;end

  def update
    if @request.update(request_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @request.destroy
    redirect_to root_path
  end

  private

  def request_params
    params.require(:request).permit(:group_id, :user_id, :take, :execution_date, :comment, :image, :give1, :give2, :give3).merge(user_id: current_user.id)
  end

  def set_request
    @request = Request.includes(user: :profile).find(params[:id])
  end

end
