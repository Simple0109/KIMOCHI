class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :set_group, only: [:new, :edit, :update, :show]

  def index
    all_requests = Request.where(group_id: params[:group_id]).order(updated_at: :desc)
    @draft_requests = Kaminari.paginate_array(all_requests.select { |request| (request.status == "draft") && (request.own?(current_user)) }).page(params[:draft_page])
    @unauthorized_requests = Kaminari.paginate_array(all_requests.select { |request| (request.status == "unauthorized") && (request.authorizers_check(current_user) || request.own?(current_user))}).page(params[:unauthorized_page])
    @authorized_requests = Kaminari.paginate_array(all_requests.select { |request| (request.status == "authorized") && (request.authorizers_check(current_user) || request.own?(current_user))}).page(params[:authorized_page])
    @possible_requests = Kaminari.paginate_array(all_requests.select { |request| (request.status == "possible")}).page(params[:possible_page])

    @group = Group.find(params[:group_id])
  end

  def new
    @request = Request.new
  end

  def show
    @subject_authorizer = RequestUser.find_by(request_id: @request.id, user_id: current_user.id)

  end

  def create
    request = Request.new(request_params)
    authorizer_ids = params[:request][:authorizer_ids].map(&:to_i)
    authorizer_ids.shift

    if request.save
      authorizer_ids.each do |authorizer_id|
        authorizer = User.find(authorizer_id)
        request.authorizers << authorizer
      end
      redirect_to group_requests_path
    else
      render :new
    end
  end

  def edit;end

  def update
    # 受け取ったidをinteger型に変換し、再びauthorizer_idsに格納
    authorizer_ids = params[:request][:authorizer_ids].map(&:to_i)
    # collection_check_boxesの使用で先頭に""が入るためそれを削除
    authorizer_ids.shift
    # すでに存在する@requestに関連づいたレコードを特定(案2)
    existing_authorizer_records = RequestUser.where(request_id: @request.id)

    if @request.update(request_params)
=begin
      # 案1
      @request.authorizers.delete_all
      authorizer_ids.each do |authorizer_id|
        authorizer = User.find(authorizer_id)
        @request.authorizers << authorizer
      end
=end
#=begin
      # 案2
      existing_authorizer_records.each do |record|
        # 取得したuser_idが既存レコードのuser_idに含まれていない場合、その既存レコードを削除
        record.delete unless authorizer_ids.include?(record.user_id)
      end
      # 取得したuser_idの配列から既存レコードのuser_idを差し引く　-> 新規登録したいuser_idを特定しnew_user_idsに格納
      new_authorizer_ids = authorizer_ids - existing_authorizer_records.pluck(:user_id)

      new_authorizer_ids.each do |new_user_id|
        new_authorizer = User.find(new_user_id)
        @request.authorizers << new_authorizer
      end
#=end
      redirect_to group_request_path(@group, @request), notice: "更新しました"
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

  def set_group
    @group = Group.includes(users: :profile).find(params[:group_id])
  end

end
