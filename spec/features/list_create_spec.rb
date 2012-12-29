require "spec_helper"

feature "user creates a list" do
  scenario "with valid title" do
    create_a_list_with_title("BBQ shopping")
    expect(page.find(".content h1")).to have_content("BBQ shopping")
  end

  scenario "with invalid title", js: true do
    create_a_list_with_title("x"*141)
    expect(page).to have_content("Title is too long")
  end

  def create_a_list_with_title(title)
    visit "/"
    fill_in "list_title", with: title
    click_on "Make a list"
  end
end
