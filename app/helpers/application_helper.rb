module ApplicationHelper
  
  # Make the title configurable and available everywhere
  def title
    base_name = "Todobadour"
    @title.nil? ? base_name : "#{base_name} : #{@title}"
  end
  
end
