class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: %i[show edit update user_requests]
  before_action :set_current_user_profile, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def personal_requests
    @personal_requests = Request.includes(user: :profile).where(user_id: current_user.id)
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :avatar, :description)
  end

  def set_current_user_profile
    @user = current_user
    @profile = @user.profile
  end
end
