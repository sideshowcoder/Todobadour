module ListsHelper

  def last_list
    if cookies["last_list"]
      begin
        list = List.by_slug(cookies["last_list"].dup.force_encoding(Encoding::UTF_8))
      rescue ActiveRecord::RecordNotFound => e
        list = nil
      end
    else
      list = nil
    end
    list
  end

end
