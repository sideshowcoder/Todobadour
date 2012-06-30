module ListsHelper
  
  def last_list
    begin
      list = List.find cookies["last_list"] if cookies["last_list"]      
    rescue ActiveRecord::RecordNotFound => e
      list = nil
    end
    list
  end
        
end
