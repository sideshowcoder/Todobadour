require "spec_helper"

feature "delete todo" do
  scenario "delete" do
    create_todo_with_title("Delete me")
    delete_todo_with_title("Delete me")
    expect(page.find("#todo-list")).to_not have_content("Delete me")
  end

  def delete_todo_with_title(title)
    page.find('a[title="' + title + '"]').click
  end
end

