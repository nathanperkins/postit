module ApplicationHelper
  def external_link(link)
    link.starts_with?('http://') ? link : "http://#{link}"
  end

  def display_datetime(dt)
    dt.strftime("%m/%d/%y %l:%M%P %Z")
  end
end
