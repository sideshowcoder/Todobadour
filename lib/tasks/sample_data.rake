namespace :db do

  desc "Fill DB with sample Data"

  task :populate => :environment do
    require "faker"
    # Clear the DB
    Rake::Task["db:reset"].invoke
    # prepare the test DB after Reset
    Rake::Task["db:test:prepare"].invoke

    List.create! :title => "Shopping", :description => "Everything for dinner"

    10.times do |n|
      title = Faker::Lorem.words.first
      description = Faker::Lorem.words.join(" ")
      List.create! :title => title, :description => description
    end
    
    10.times do |n|
      title = Faker::Lorem.words.first
      List.create! :title => title
    end
    
    List.all(:limit => 15).each do |l|
      20.times do 
        l.todos.create! :title => Faker::Lorem.words.join(" ")
      end
      
      10.times do 
        l.todos.create! :title => Faker::Lorem.words.join(" "), :done => true
      end
    end    
  end
  
end