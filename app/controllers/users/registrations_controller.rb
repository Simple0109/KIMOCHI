class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
    @user.build_profile
  end
end
