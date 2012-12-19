module Features
  module TodoHelpers
    def create_todo_with_title(title)
      visit list_path(FactoryGirl.create(:list))
      fill_in "todo_title", with: title
      click_on "Add"
      sleep 1
      Todo.last
    end
  end
end
