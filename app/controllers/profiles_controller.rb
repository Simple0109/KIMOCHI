class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def show
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to new_user_session_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :avatar, :role, :description).merge(user_id: current_user.id)
  end
end
