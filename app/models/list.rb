class List < ActiveRecord::Base
  attr_accessible :title, :description, :slug
  
  has_many :todos, :dependent => :destroy
  
  before_validation :generate_and_add_slug
  
  validates :title, :presence => true,
                    :length => { :maximum => 140 }
  
  validates :slug, :uniqueness => true,
                   :presence => true
                   
  private
    # generate a slug if none present before trying to validate
    def generate_and_add_slug
      if self.slug.nil? || self.slug.empty?
        self.slug = Digest::SHA1.hexdigest([Time.now, rand].join) 
      end
      self
    end                 
end
