class PersonalRequestsController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_user, only: %i[index]

  def index
    @requests = Request.where(user_id: current_user.id)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
