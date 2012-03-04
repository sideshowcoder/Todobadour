class PagesController < ApplicationController

  def about
    @title = "About"
  end
  
  def home
    @list = List.new
  end
  
end
