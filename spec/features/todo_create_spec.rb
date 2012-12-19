require "spec_helper"

feature "create todo" do
  scenario "with valid title" do
    create_todo_with_title("Sauce")
    expect(page.find("#todo-list")).to have_content("Sauce")
  end

  scenario "with invalid title"

end

