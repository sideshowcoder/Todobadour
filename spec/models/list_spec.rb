require 'spec_helper'
require "faker"

describe List do

  it "should generate a slug on save if none is present" do
    list = List.create!({ title: "just a title" })
    list.slug.should_not be_blank
  end

  it "should find a list by it's slug" do
    list = FactoryGirl.create(:list)
    List.by_slug(list.slug).should == list
  end

  describe "todo association" do
    before :each do
      @list = FactoryGirl.create :list
      @t0 = FactoryGirl.create :todo, list: @list, created_at: 2.day.ago, position: 1
      @t1 = FactoryGirl.create :todo, list: @list, created_at: 1.day.ago, position: 3
      @t2 = FactoryGirl.create :todo, list: @list, created_at: 1.hour.ago, position: 2
    end

    it "should return the todos in oder of order" do
      @list.todos.rank(:position).should == [@t0, @t2, @t1]
    end
  end

  describe "share via email" do
    before :each do
      @list = FactoryGirl.create :list
      @sender = "test@test.com"
      @receiver = "test2@test2.com"
      @message = Faker::Lorem.paragraph
    end

    it "should share itself via email" do
      @list.share_via_email @sender, @receiver, @message
      ActionMailer::Base.deliveries.last.to.should == [@receiver]
    end
  end

end
