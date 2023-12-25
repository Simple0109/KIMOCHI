class ApprovalsController < ApplicationController
  before_action :authenticate_user!, only: %i[admit cancel_admit]
  before_action :set_group, only: %i[admit cancel_admit]
  before_action :set_request, only: %i[admit cancel_admit]

  # 承認(authorizersのレコードの数と承認の数が一致したとき、request.statusをpossibleに更新)
  def admit
    subject_authorizer = RequestUser.find_by(request_id: @request.id, user_id: current_user.id)
    if current_user.id == subject_authorizer.user_id && subject_authorizer.unauthorized?
      subject_authorizer.authorized!
      @request.authorized! if @request.authorizers.pluck(:approval_status).sum == @request.authorizers.count
      redirect_to group_requests_path, notice: '承認しました'
    else
      redirect_to group_request_path(@group, @request), notice: '承認に失敗しました'

    end
  end

  # 承認取消(authorizersのレコードの数と承認の数が不一致になった時、request.statusをunauthorizedに更新)
  def cancel_admit
    subject_authorizer = RequestUser.find_by(request_id: @request.id, user_id: current_user.id)
    if current_user.id == subject_authorizer.user_id && subject_authorizer.authorized?
      subject_authorizer.unauthorized!
      @request.unauthorized! if @request.authorizers.pluck(:approval_status).sum <= @request.authorizers.count
      redirect_to group_requests_path, notice: '承認を取り消しました'
    else
      redirect_to group_request_path(@group, @request), notice: '承認取り消しに失敗しました'
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_request
    @request = Request.find(params[:request_id])
  end
end
