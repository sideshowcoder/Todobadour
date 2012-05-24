class Todo < ActiveRecord::Base
  attr_accessible :title, :done, :position
  
  belongs_to :list  
  
  before_validation :default_values
  
  validates :title, :presence => true,
                    :length => { :maximum => 140 }

  validates :list_id, :presence => true
  
  include RankedModel
  ranks :position
  
  private
    def default_values
      self.done ||= false
      self
    end
  
end
