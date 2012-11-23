def todo_visible_in_list(todo_text)
  page.find("#todo-list").should have_content(todo_text)
end

def todo_not_visible_in_list(todo_text)
  page.find("#todo-list").should_not have_content(todo_text)
end

def todo_is_done(todo_text)
  page.find("#todo-list li.done").should have_content(todo_text)
end

def todo_is_not_done(todo_text)
  page.find("#todo-list li.not-done").should have_content(todo_text)
end

def toggle_todo_done(todo)
  page.find("#todo-#{todo.id} span.done").click
  sleep 1 # wait for ajax
end

Given /^there is a todo named "(.*?)"$/ do |todo_text|
  @todo = FactoryGirl.create(:todo, title: todo_text, list: @list)
end

Given /^There is a list named "Shopping"$/ do
  @list = FactoryGirl.create(:list, title: "Shopping", slug: "shopping")
end

Given /^there is a todo named "(.*?)" marked not done$/ do |todo_text|
  @todo = FactoryGirl.create(:todo, done: false, title: todo_text, list: @list)
end

Given /^there is a todo named "(.*?)" marked done$/ do |todo_text|
  @todo = FactoryGirl.create(:todo, done: true, title: todo_text, list: @list)
end

When /^I am viewing the "Shopping" list$/ do
  visit "/lists/shopping"
end

When /^I am reloading the "Shopping" list$/ do
  visit "/lists/shopping"
end

When /^I create a todo "(.*?)"$/ do |todo_text|
  fill_in "todo_title", with: todo_text
  click_on "Add"
end

When /^I toggle the todo "(.*?)" done$/ do |arg1|
  toggle_todo_done(@todo)
end

Then /^I should see "(.*?)"$/ do |todo_text|
  todo_visible_in_list(todo_text)
end

Then /^I should see the todo "(.*?)" marked as done$/ do |todo_text|
  todo_is_done(todo_text)
end

Then /^I should see the todo "(.*?)" marked as not-done$/ do |todo_text|
  todo_is_not_done(todo_text)
end


When /^I delete the todo "(.*?)"$/ do |arg1|
  within("#todo-#{@todo.id}") do
    click_on "delete"
  end
end

Then /^I should not see the todo "(.*?)"$/ do |todo_text|
  todo_not_visible_in_list(todo_text)
end

When /^I click on the todo title$/ do
  page.find("#todo-#{@todo.id} span.title span.best_in_place").click
end

When /^I fill in "(.*?)"$/ do |new_todo_text|
  within("#todo-#{@todo.id} form.form_in_place") do
    fill_in "title", with: new_todo_text
  end
  page.find("body").click
  sleep 1
end
