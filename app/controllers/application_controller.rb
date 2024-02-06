class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [profile_attributes: [:name]])
  end

  private

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end

  def after_sign_in_path_for(resource)
    Rails.logger.info "after_sign_in_path_for called"
    if session[:group_id].present?
      group = Group.find_by(id: session[:group_id])
      if GroupUser.find_by(group_id: group.id, user_id: resource.id).present?
        session[:group_id] = nil
        group.update(invite_token: nil)
        flash[:alert] = "すでに#{group.name}グループに参加しています"
      else
        GroupUser.create(user_id: resource.id, group_id: group.id)
        session[:group_id] = nil
        group.update(invite_token: nil)
        flash[:notice] = "#{group.name}グループに追加されました"
      end
    end

    if resource.sign_in_count == 1
      root_path
    else
      profile_path(resource)
    end
  end

  def after_sign_up_path_for(resource)
    group = Group.find_by(id: session[:group_id])

    if session[:group_id].present?
      GroupUser.create(user_id: resource.id, group_id: group.id)
      session[:group_id] = nil
      group.update(invite_token: nil)
      flash[:notice] = "#{group.name}グループに追加されました"
    else
      session[:group_id] = nil
      group.update(invite_token: nil)
    end

    super
  end
end
