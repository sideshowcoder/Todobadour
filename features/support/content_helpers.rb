def page_title(title)
  within('head title') do
    page.should have_content(title)
  end
end
