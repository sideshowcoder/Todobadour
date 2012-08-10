class List < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug
  
  attr_accessible :title, :description, :slug
  
  has_many :todos, :dependent => :destroy
  
  before_validation :generate_and_add_slug
  
  validates :title, :presence => true,
                    :length => { :maximum => 140 }
  
  validates :slug, :uniqueness => true,
                   :presence => true
  
  def ordered_todos
    self.todos.rank(:position)
  end
  
  def share_via_email sender, receiver, message
    Resque.enqueue ShareMailSender, self.id, sender, receiver, message
  end
  
  private
    # generate a slug if none present before trying to validate
    def generate_and_add_slug
      if self.slug.nil? || self.slug.empty?
        self.slug = SecureRandom.hex 16
      end
      self
    end                 
end
