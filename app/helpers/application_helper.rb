module ApplicationHelper
  def external_link(link)
   if link.include?("http://")
    puts link
   else
    link.insert(0, "http://")
    link
   end
  end
end
