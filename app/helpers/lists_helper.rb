module ListsHelper
  
  def last_list
    List.find cookies["last_list"] if cookies["last_list"]
  end
      
end
