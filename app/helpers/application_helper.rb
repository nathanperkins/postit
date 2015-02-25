module ApplicationHelper
  def external_link(link)
    link.starts_with?('http://') ? link : "http://#{link}"
  end
end
