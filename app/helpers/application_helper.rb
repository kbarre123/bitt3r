module ApplicationHelper
  
  # Returns the full title
  def full_title(page_title)
    base_title = "bitt3r"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end  
  end
  
end
