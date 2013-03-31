class Contact < ActiveRecord::Base
  acts_as_paranoid

  default_scope :order => 'created_at DESC'

  attr_accessible :content, :email, :name

  validates :name, :presence => true
  validates :email, :presence => true
  validates :content, :presence => true
  
end
