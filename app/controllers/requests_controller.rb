class RequestsController < ApplicationController
  before_action :authenticate_user!, only: %i[index new show create edit update destroy]
  before_action :set_request, only: %i[show edit update destroy]
  before_action :set_group, only: %i[index new show edit update destroy]

  def index
    all_requests = Request.includes(user: :profile).where(group_id: params[:group_id]).order(updated_at: :desc)
    @unauthorized_requests = paginated_unauthorized_requests(all_requests, params[:unauthorized_page])
    @authorized_requests = paginated_authorized_requests(all_requests, params[:authorized_page])
    @possible_requests = paginated_possible_requests(all_requests, params[:possible_page])
  end

  def completed_requests
    all_requests = Request.includes(user: :profile).where(group_id: params[:group_id]).order(updated_at: :desc)
    @completed_requests = paginated_completed_requests(all_requests, params[:completed_page])
  end

  def show
    @subject_authorizer = RequestUser.find_by(request_id: @request.id, user_id: current_user.id)

    @gives = Give.where(request_id: @request.id)
    @uncompleted_gives = @gives.where(status: 0).order(:id)
    @completed_gives = @gives.where(status: 1).order(:id)
    @messages = @request.messages.all
  end

  def new
    @request = Request.new
    3.times { @request.gives.build }
  end

  def edit; end

  def create
    request = Request.new(request_params)
    authorizer_ids = params[:request][:authorizer_ids].map(&:to_i)
    authorizer_ids.shift

    request.user_uid = current_user.uid

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

  def update
    authorizer_ids = params[:request][:authorizer_ids].map(&:to_i)
    authorizer_ids.shift
    existing_authorizer_records = RequestUser.where(request_id: @request.id)

    if @request.update(request_params)
      existing_authorizer_records.each do |record|
        record.destroy unless authorizer_ids.include?(record.user_id)
      end
      new_authorizer_ids = authorizer_ids - existing_authorizer_records.pluck(:user_id)

      new_authorizer_ids.each do |new_user_id|
        new_authorizer = User.find(new_user_id)
        @request.authorizers << new_authorizer
      end
      redirect_to group_request_path(@group, @request), notice: '更新しました'
    else
      render :edit
    end
  end

  def destroy
    return unless @request.own?(current_user)

    @request.destroy
    redirect_to group_requests_path(@group, @request)
  end

  private

  def request_params
    params.require(:request).permit(:group_id, :user_id, :take, :execution_date, :comment, :image,
                                    gives_attributes: %i[id content deadline]).merge(user_id: current_user.id)
  end

  def set_request
    @request = Request.includes(user: :profile).find(params[:id])
  end

  def set_group
    @group = Group.includes(users: :profile).find(params[:group_id])
  end

  def paginated_unauthorized_requests(requests, page)
    filtered_requests = requests.select { |request| (request.unauthorized?) && (request.authorizers_check(current_user) || request.own?(current_user)) }
    Kaminari.paginate_array(filtered_requests).page(page)
  end

  def paginated_authorized_requests(requests, page)
    filtered_requests = requests.select { |request| (request.authorized?) && (request.authorizers_check(current_user) || request.own?(current_user)) }
    Kaminari.paginate_array(filtered_requests).page(page)
  end

  def paginated_possible_requests(requests, page)
    filtered_requests = requests.select { |request| (request.possible?) }
    Kaminari.paginate_array(filtered_requests).page(page)
  end

  def paginated_completed_requests(requests, page)
    filtered_requests = requests.select { |request| (request.status == "completed") }
    Kaminari.paginate_array(filtered_requests).page(page)
  end
end
