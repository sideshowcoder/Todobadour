require "spec_helper"

feature "visit pages" do
  scenario "home page" do
    visit "/"
    expect(page.find("title")).to have_content("Todobadour")
  end

  scenario "about page" do
    on_the_home_page_click("About")
    expect(page.find("title")).to have_content("Todobadour - About")
  end


  def on_the_home_page_click(link)
    visit "/"
    click_on "About"
  end
end
