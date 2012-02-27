class List < ActiveRecord::Base
  attr_accessible :title, :description, :slug
  
  validates :title, :presence => true,
                    :length => { :maximum => 140 }
  
  validates :slug, :uniqueness => true, 
                   :presence => true
end
