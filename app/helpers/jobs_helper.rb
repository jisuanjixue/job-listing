module JobsHelper
  def render_highlight_content(job,query_string)
    excerpt_cont = excerpt(job.title, query_string, radius: 500)
    highlight(excerpt_cont, query_string)
  end

  def resource_name
  :user
  end

  def resource
  @resource ||= User.new
  end

  def devise_mapping
  @devise_mapping ||= Devise.mappings[:user]
  end

end
