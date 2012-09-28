When /^I create the "(.*?)" list$/ do |list_title|
  fill_in "list_title", with: list_title
  click_on "Make a list"
end

Then /^I should see "(.*?)" as my list$/ do |list_title|
  page.should have_content(list_title)
end

