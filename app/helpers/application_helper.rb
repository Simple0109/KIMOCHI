module ApplicationHelper
  def flash_class_for(key)
    case key.to_sym
    when :notice
      'bg-green-100 text-green-800'
    when :alert
      'bg-red-100 text-red-800'
    else
      'bg-gray-100 text-gray-800'
    end
  end

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

  def header_top_class
    if params[:controller] == 'top_page' && params[:action] == 'top'
      'text-blue-500'
    else
      'text-gray-500'
    end
  end

  def status_bg_color(status)
    case status
    when 'unauthorized'
      'bg-red-100'
    when 'authorized'
      'bg-blue-100'
    when 'possible'
      'bg-purple-300'
    when 'completed'
      'bg-teal-400'
    else
      'bg-gray-500'
    end
  end

  def default_meta_tags
    {
      site: 'KIMOCHI',
      title: '',
      reverse: true,
      charset: 'utf-8',
      description: '「言いたいけど言えない」そんなもやもやの解決を手助けできるかもしれません',
      keywords: 'もやもや,言いにくい,言い出しづらい',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary',
        site: '@simplerunteq44',
        image: image_url('ogp.png')
      }
    }
  end
end
