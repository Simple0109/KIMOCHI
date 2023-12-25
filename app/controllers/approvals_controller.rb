class ApprovalsController < ApplicationController
  before_action :set_group, only: %i[apply cancel_apply admit cancel_admit]
  before_action :set_request, only: %i[apply cancel_apply admit cancel_admit]

  # 申請
  def apply
    if @request.user_id == current_user.id
      @request.unauthorized!
      redirect_to group_requests_path, notice: 'リクエストの申請を行いました'
    else
      redirect_to group_request_path(@request), notice: 'リクエストの申請に失敗しました'
    end
  end

  # 申請取消(同時にrequest_usersのapproval_statusも全てunauthorizedに変更)
  def cancel_apply
    authorizers = RequestUser.where(request_id: @request.id)
    if @request.user_id == current_user.id
      @request.draft!
      authorizers.each do |authorizer|
        authorizer.unauthorized!
      end
      redirect_to group_requests_path, notice: 'リクエストの申請を取り消しました'
    else
      redirect_to group_request_path(@request), notice: 'リクエストの申請取り消しに失敗しました'
    end
  end

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
