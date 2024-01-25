module ApplicationHelper
  def sidebar_link_class(group)
    if (params[:controller] == 'groups' && ['show', 'edit'].include?(params[:action]) && params[:id] == group.id.to_s) ||
       (params[:controller] == 'requests' && ['index', 'show', 'new', 'edit', 'completed_requests'].include?(params[:action]) && params[:group_id] == group.id.to_s)
      'text-blue-500'
    else
      'text-gray-500'
    end
  end

  def header_group_new_class
    if params[:controller] == 'groups' && params[:action] == 'new'
      'text-blue-500'
    else
      'text-gray-500'
    end
  end

  def header_group_index_class
    if params[:controller] == 'groups' && params[:action] == 'index'
      'text-blue-500'
    else
      'text-gray-500'
    end
  end

  def header_profile_class
    if params[:controller] == 'profiles' && ['show', 'edit', 'personal_requests'].include?(params[:action])
      'text-blue-500'
    else
      'text-gray-500'
    end
  end
end
