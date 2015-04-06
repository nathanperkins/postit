module ApplicationHelper
  def external_link(link)
    link.starts_with?('http://') ? link : "http://#{link}"
  end

  def display_datetime(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone current_user.time_zone
    end

    dt.strftime("%m/%d/%y %l:%M%P %Z")
  end
end
