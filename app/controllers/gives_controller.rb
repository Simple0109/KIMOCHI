class GivesController < ApplicationController
  before_action :set_group, only: %i[update_status_completed update_status_uncompleted]
  before_action :set_request, only: %i[update_status_completed update_status_uncompleted]
  before_action :set_give, only: %i[update_status_completed update_status_uncompleted]

  def update_status_completed
    if @give.update(status: 1)
      redirect_to group_request_path(@group, @request), notice: "#{@give.content}を完了しました"
      @request.possible! if @request.gives.pluck(:status).sum == @request.gives.count
    else
      redirect_to group_request_path(@group, @request), alert: '更新に失敗しました'
    end
  end

  def update_status_uncompleted
    @give = Give.find(params[:id])
    if @give.update(status: 0)
      redirect_to group_request_path(@group, @request), notice: "#{@give.content}を未完了にしました"
      @request.authorized! if @request.gives.pluck(:status).sum <= @request.gives.count
    else
      redirect_to group_request_path(@group, @request), alert: '更新に失敗しました'
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_request
    @request = Request.find(params[:request_id])
  end

  def set_give
    @give = Give.find(params[:id])
  end
end
