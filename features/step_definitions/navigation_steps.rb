Given /^I am on the "(.*?)" page$/ do |page|
  if page == "Home"
    visit "/"
  end
end

When /^I follow the "(.*?)" link$/ do |link_text|
  click_on link_text
end

Then /^I should see "(.*?)" in the title$/ do |title_text|
  page_title title_text
end


