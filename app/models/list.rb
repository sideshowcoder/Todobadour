class List < ActiveRecord::Base
  attr_accessible :title, :description, :slug
  
  validates :title, :presence => true
end
