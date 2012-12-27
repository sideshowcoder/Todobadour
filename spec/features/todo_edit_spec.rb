# encoding: UTF-8

require "spec_helper"

feature "edit todo" do
  before(:each) { @todo = create_todo_with_title("Mark me") }
  scenario "mark done", js: true  do
    expect(page).to have_content("✓")
    toggle_done_for_todo(@todo)
    expect(page).to have_content("☓")
  end

  scenario "mark not done", js: true do
    toggle_done_for_todo(@todo)
    toggle_done_for_todo(@todo)
    expect(page).to have_content("✓")
  end

  scenario "change title to valid title", js: true do
    change_todo_title_for_todo("Changed", @todo)
    expect(page).to have_content("Changed")
  end

  scenario "change title to invalid title"

  def toggle_done_for_todo(todo)
    page.find("#todo-#{todo.id} span.done").click
    sleep 1
  end

  def change_todo_title_for_todo(title, todo)
    within("#todo-#{todo.id}") do
      page.find("[data-attribute=title]").click
      fill_in "title", with: title
      page.evaluate_script("$('#todo-#{todo.id} [data-attribute=title] form').submit()")
      sleep 1
    end
  end
end

